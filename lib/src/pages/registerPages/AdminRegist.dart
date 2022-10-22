import 'package:DAAC_APP/src/model/Administrador.dart';
import 'package:DAAC_APP/src/pages/WindowsSize.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../widgetsPerzonalizados/DaacForms.dart';

class AdminRegist extends StatefulWidget {
  static String id = "AdminRegist";

  @override
  State<AdminRegist> createState() => AdminRegistState();
}

class AdminRegistState extends State<AdminRegist> {
  //Controladores de los textField del formulario
  TextEditingController usuario = TextEditingController();
  TextEditingController contrasena = TextEditingController();
  TextEditingController clon_contrasena = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController apellido = TextEditingController();
  TextEditingController edad = TextEditingController();

  //-------

  DaacForms forms = DaacForms();
  String? genero = "";
  WindowsSize size = WindowsSize();
  final _formKey = GlobalKey<FormState>();
  final firebase = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final cli = ModalRoute.of(context)!.settings.arguments as Administrador?;
    Administrador? admin = cli;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text("Modificar cliente"),
      ),
      body: SingleChildScrollView(child: formAdmin()),
    );
  }

  //Formulario de cliente
  Widget formAdmin() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: size.heightSize(20, context)),
          profileImage(context),
          forms.formFieldText("Nombre Usuario", context, usuario),
          forms.formFieldText("Contraseña", context, contrasena),
          forms.formFielVPassword("Confirmar contraseña", context,
              clon_contrasena, true, validatePassword),
          forms.formFieldText("Nombres", context, nombre),
          forms.formFieldText("Apellidos", context, apellido),
          forms.formFieldText("Edad", context, edad),
          genderDropDownField(),
          buttonSubmit(context),
        ],
      ),
    );
  }

  Widget genderDropDownField() {
    String? select = "Masculino";
    final List<String> _lista = ["Masculino", "Femenino"];
    return Padding(
      padding: EdgeInsets.only(
          top: size.heightSize(20, context),
          left: size.widthSize(20, context),
          right: size.widthSize(20, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField(
              decoration: InputDecoration(
                label: Text("Genero",
                    style: TextStyle(fontSize: 18, color: Colors.black54)),
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              hint: const Text(
                '   Seleccione el genero',
                style: TextStyle(fontSize: 16),
              ),
              value: select,
              isExpanded: true,
              items: _lista.map((e) {
                return DropdownMenuItem(
                  child: Text(e),
                  value: e,
                );
              }).toList(),
              onChanged: (String? e) {
                select = e;
                genero = select;
              }),
        ],
      ),
    );
  }

  //Agrega el usuario a la base de datos solo o con mascota.
  addAdmin() async {
    try {
      await firebase.collection('Usuario').doc().set({
        "usuario": usuario.text,
        "contraseña": contrasena.text,
        "nombre": nombre.text,
        "apellido": apellido.text,
        "edad": edad.text,
        "genero": genero,
        "rol": "administrador",
        "estado": "activo",
      });
      Navigator.pop(context);
    } catch (e) {
      print("ERROR..." + e.toString());
    }
  }

  String? validatePassword(String? value) {
    if (value != contrasena.text) {
      return "Las contraseñas no coinciden";
    }
    return null;
  }

  Widget buttonSubmit(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          print(contrasena.text);
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Processing Data')));
            addAdmin();
          } else {
            print("AH ocurrido un error, revise el form");
          }
        },
        child: Text('Modificar'),
      ),
    );
  }

  Widget profileImage(context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: size.heightSize(20, context),
          left: size.widthSize(15, context)),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: 80,
            backgroundColor: Colors.black54,
            child: ClipOval(
              child: SizedBox(
                width: 195.0,
                height: 195.0,
                child: Image.asset(
                  'images/siinFoto.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: size.heightSize(60, context)),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: Colors.white,
            ),
            onPressed: () {},
            child: Container(
              height: 40,
              width: 40,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'images/add-photo.png',
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
