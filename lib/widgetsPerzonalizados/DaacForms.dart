import 'package:DAAC_APP/src/model/Canino.dart';
import 'package:DAAC_APP/src/pages/WindowsSize.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../src/model/Cliente.dart';
import '../src/model/Raza.dart';



class DaacForms {
  DaacForms();

  TextEditingController nomPerro = TextEditingController();
  TextEditingController idRaza = TextEditingController();
  TextEditingController edadPerro = TextEditingController();
  TextEditingController estadoPerro = TextEditingController();

  final firebase = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final _formPetKey = GlobalKey<FormState>();
  WindowsSize size = WindowsSize();
  late String descRaza;
  List<Raza> razas = [];

  Widget formFieldUser(
    String _label,
    context,
    TextEditingController controller,
  ) {
    return Padding(
      padding: EdgeInsets.only(
          top: size.heightSize(10, context),
          left: size.widthSize(20, context),
          right: size.widthSize(20, context)),
      child: TextFormField(
        controller: controller,

        //validator: validateUserExist,
        decoration: InputDecoration(
            labelText: _label,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }

//Campo de texto validado
  Widget formFieldText(
    String _label,
    context,
    TextEditingController controller,
  ) {
    return Padding(
      padding: EdgeInsets.only(
          top: size.heightSize(10, context),
          left: size.widthSize(20, context),
          right: size.widthSize(20, context)),
      child: TextFormField(
        controller: controller,
        validator: validateString,
        decoration: InputDecoration(
            labelText: _label,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }

  //Formulario modificar mascota
  Widget formPetUpdate(cliente, context, razas) {
    
    
    
    return Container(
      color: Colors.white,
      child: Form(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(
                top: size.heightSize(20, context),
                bottom: size.heightSize(40, context)),
            child: Text(
              "Ingrese los datos de la mascota",
              style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center,
            ),
          ),
          formFieldText(
              "Nombre", context, textController(cliente!.m_nombretoString())),
          formFieldText("Edad en meses", context,
              textController(cliente!.m_edad.toString())),
          razaDopDownField(context, "Doberman", razas)
        ]),
      ),
    );
  }

  Widget formPet(context, razas) {
    return Container(
      color: Colors.white,
      child: Form(
        key: _formPetKey,
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(
                top: size.heightSize(40, context),
                bottom: size.heightSize(40, context)),
            child: Text(
              "Ingrese los datos de la mascota",
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
          formFieldText("Nombre", context, nomPerro),
          formFieldText("Edad en meses", context, edadPerro),
          razaDopDownField(context, "Doberman", razas),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formPetKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')));
                        addPet(context);
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Agregar'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar'),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  addPet(Cliente? cliente) async {
    try {
      Canino canino = Canino("", cliente!.id, nomPerro.text, edadPerro.text, idRaza.text, "activo");
    } catch (e) {
      print("ERROR..." + e.toString());
    }
  }

  //Lista desplegable con las razas
  Widget razaDopDownField(context, String? selected, List<Raza> razas) {
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
                '   Seleccione raza',
                style: TextStyle(fontSize: 16),
              ),
              value: selected,
              isExpanded: true,
              items: razas.map((e) {
                return DropdownMenuItem(
                  child: Text("   " + e.descripcion.toString()),
                  value: e.descripcion.toString(),
                );
              }).toList(),
              onChanged: (e) {
                selected = e.toString();
                descRaza = selected.toString();
              }),
        ],
      ),
    );
  }

  //Convierte string a TextController
  TextEditingController textController(String value) {
    TextEditingController _controller = new TextEditingController();
    _controller.text = value;
    return _controller;
  }

  //valida que ingrese un dato
  String? validateString(String? value) {
    if (value?.length == 0) {
      return "*El campo es obligatorio";
    }
    return null;
  }

  //valida que ingrese un dato
  Future<String?> validateUserExist(String? value) async {
    CollectionReference ref = FirebaseFirestore.instance.collection("Usuario");
    QuerySnapshot usuario = await ref.get();
    for (var u in usuario.docs) {
      if (u.get("usuario" == value.toString())) {
        return "El usuario ya existe";
      }
    }
    return null;
  }

  //Valida que se ingrese solo numeros
  String? validateNumber(String? value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value?.length == 0) {
      return "La edad no puede ir vacia";
    } else if (!regExp.hasMatch(value!)) {
      return "Solo ingrese numeros";
    }
    return null;
  }

  //Campo de input de solo numeros
  Widget formFieldNumber(
    String _label,
    context,
    TextEditingController controller,
  ) {
    return Padding(
      padding: EdgeInsets.only(
          top: size.heightSize(10, context),
          left: size.widthSize(20, context),
          right: size.widthSize(20, context)),
      child: TextFormField(
        controller: controller,
        validator: validateNumber,
        decoration: InputDecoration(
            labelText: _label,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }

  //campo validado para contraseña
  Widget formFielVPassword(String _label, context,
      TextEditingController controller, bool obscureText, validatePassword) {
    return Padding(
      padding: EdgeInsets.only(
          top: size.heightSize(10, context),
          left: size.widthSize(20, context),
          right: size.widthSize(20, context)),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        validator: validatePassword,
        decoration: InputDecoration(
            labelText: _label,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }

  Future<void> deleteAlertDialog(context, DocumentReference<Object?> a) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('OJO!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Seguto que quieres eliminar este usuario ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                a.delete();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }


}
