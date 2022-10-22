import 'package:DAAC_APP/src/pages/WindowsSize.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../widgetsPerzonalizados/DaacForms.dart';
import '../../widgetsPerzonalizados/PetCard.dart';
import '../model/Canino.dart';
import '../model/Cliente.dart';
import '../model/Raza.dart';

class Registro extends StatefulWidget {
  static String id = "registro";

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  TextEditingController usuario = TextEditingController();
  TextEditingController contrasena = TextEditingController();
  TextEditingController clon_contrasena = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController apellido = TextEditingController();
  TextEditingController edad = TextEditingController();
  TextEditingController m_nombre = TextEditingController();
  TextEditingController m_edad = TextEditingController();
  TextEditingController m_raza = TextEditingController();

  Cliente cliente = Cliente.c1();
  

  List<Raza> razas = [];
  String? genero = "";
  String? selectedItem = "Masculino";
  WindowsSize size = WindowsSize();
  final _formKey = GlobalKey<FormState>();
  final firebase = FirebaseFirestore.instance;
  DaacForms forms = DaacForms();
  PetCard petCard = PetCard();
  Canino canino = Canino.const1();
  

  @override
  Widget build(BuildContext context) {
    listaDeRazas();
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text("Registro usuario"),
      ),
      body: SingleChildScrollView(child: formCliente(context)),
    );
  }

  Future listaDeRazas() async {
    bool exist = false;
    try {
      CollectionReference ref = FirebaseFirestore.instance.collection("Raza");
      QuerySnapshot raza = await ref.get();

      
      if (razas.isEmpty) {
        for (var r in raza.docs) {
          razas.add(Raza(r.id, r.get("descripcion"), r.get("estado")));
        }
      } else {
        raza.docs.forEach((element1) {
          razas.forEach((element2) {
            if (element2.descripcion == element1.get("descripcion")) {
              exist = true;
            }
          });
          if (!exist) {
            razas.add(Raza(element1.id, element1.get("descripcion"),
                element1.get("estado")));
          }
        });
      }
    } catch (e) {
      print('ERROR listaDeRazas' + e.toString());
    }
  }

  Widget formCliente(context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: size.heightSize(20, context)),
          profileImage(context),
          forms.formFieldText(
            "Nombre Usuario",
            context,
            usuario,
          ),
          forms.formFieldText(
            "Contraseña",
            context,
            contrasena,
          ),
          forms.formFielVPassword(
              "Confirmar contraseña", context, clon_contrasena, true, validatePassword),
          forms.formFieldText(
            "Nombres",
            context,
            nombre,
          ),
          forms.formFieldText(
            "Apellidos",
            context,
            apellido,
          ),
          forms.formFieldNumber(
            "Edad",
            context,
            edad,
          ),
          genderDropDownField(),
          
          petCard.petCard0(context,cliente, razas, false),
          buttonSubmit(context),
        ],
      ),
    );
  }

  Widget genderDropDownField() {
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
              value: selectedItem,
              isExpanded: true,
              items: _lista.map((e) {
                return DropdownMenuItem(
                  child: Text(e),
                  value: e,
                );
              }).toList(),
              onChanged: (String? e) {
                selectedItem = e;
                genero = selectedItem;
              }),
        ],
      ),
    );
  }

  addUser() async {
    try {
      await firebase.collection('Usuario').doc().set({
        "usuario": usuario.text,
        "contraseña": contrasena.text,
        "nombre": nombre.text,
        "apellido": apellido.text,
        "edad": edad.text,
        "genero": genero,
        "rol": "cliente",
        "m_nombre": m_nombre.text,
        "m_edad": m_edad.text,
        "m_raza": m_raza.text,
        "estado": "activo",
      });
    } catch (e) {
      print("ERROR..." + e.toString());
    }
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

  Widget buttonSubmit(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Processing Data')));
          } else {
            print("AH ocurrido un error, revise el form");
          }
          addUser();
          Navigator.pop(context);
        },
        child: Text('Submit'),
      ),
    );
  }

  String? validatePassword(String? value) {
    if (value != contrasena.text) {
      return "Las contraseñas no coinciden";
    }
    return null;
  }
}
