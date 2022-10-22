import 'dart:io';

import 'package:DAAC_APP/src/pages/WindowsSize.dart';
import 'package:DAAC_APP/widgetsPerzonalizados/PetCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../widgetsPerzonalizados/DaacForms.dart';
import '../../model/Canino.dart';
import '../../model/Cliente.dart';
import '../../model/Raza.dart';

class ClienteUpdate extends StatefulWidget {
  static String id = "registro";

  @override
  State<ClienteUpdate> createState() => ClienteUpdateState();
}

class ClienteUpdateState extends State<ClienteUpdate> {
  //Controladores de los textField del formulario
  TextEditingController usuario = TextEditingController();
  TextEditingController contrasena = TextEditingController();
  TextEditingController clon_contrasena = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController apellido = TextEditingController();
  TextEditingController edad = TextEditingController();
  TextEditingController m_nombre = TextEditingController();

  TextEditingController m_edad = TextEditingController();
  TextEditingController estadoPerro = TextEditingController();

  //-------

  DaacForms forms = DaacForms();
  PetCard petCard = PetCard();
  late String descRaza;
  String? genero = "";
  String? m_raza = "";
  late String estado;
  WindowsSize size = WindowsSize();
  final _formKey = GlobalKey<FormState>();
  final firebase = FirebaseFirestore.instance;
  Canino canino = Canino.const1();
  List<Raza> razas = [];
  

  @override
  Widget build(BuildContext context) {
    final cli = ModalRoute.of(context)!.settings.arguments as Cliente?;
    Cliente? cliente = cli;
    listaDeRazas();
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text("Modificar cliente"),
      ),
      body: SingleChildScrollView(child: formCliente(cliente!)),
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

  //Formulario de cliente
  Widget formCliente(Cliente cliente) {
    usuario = forms.textController(cliente.usuario.toString());
    contrasena = forms.textController(cliente.contrasena.toString());
    nombre = forms.textController(cliente.nombre.toString());
    apellido = forms.textController(cliente.apellido.toString());
    edad = forms.textController(cliente.edad.toString());
    m_nombre = forms.textController(cliente.m_nombre.toString());
    m_edad = forms.textController(cliente.m_edad.toString());
    genero = cliente.genero;
    m_raza = cliente.m_raza; 
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: size.heightSize(20, context)),
          profileImage(context),
          forms.formFieldText("Nombre Usuario", context,
              usuario),
          forms.formFieldText("Contraseña", context,
              contrasena),
          forms.formFielVPassword(
              "Confirmar contraseña", context, clon_contrasena, true, validatePassword),
          forms.formFieldText("Nombres", context,
              nombre),
          forms.formFieldText("Apellidos", context,
              apellido),
          forms.formFieldText(
              "Edad", context, edad),
          if(cliente.genero == "Masculino")...[
            genderDropDownField(),
            ]else...[
              genderDropDownField(),
              ],
          petCard.petCard0(context, cliente, razas, false),
          buttonSubmit(context, cliente),
        ],
      ),
    );
  }

  Widget genderDropDownField() {
    String? select= "Masculino";
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
  updateCliente(Cliente? cliente) async {
    try {
      


      await firebase.collection('Usuario').doc(cliente!.id.toString()).set({
        "usuario": usuario.text,
        "contraseña": contrasena.text,
        "nombre": nombre.text,
        "apellido": apellido.text,
        "edad": edad.text,
        "genero": genero,
        "rol": "cliente",
        "m_nombre": m_nombre.text,
        "m_edad": m_edad.text,
        "m_raza": m_raza,
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
  
  Widget buttonSubmit(context, Cliente? cliente) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          print(contrasena.text);
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Processing Data')));
            updateCliente
          (cliente);
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
