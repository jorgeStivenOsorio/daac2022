import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:profile/profile.dart';

import '../src/model/Canino.dart';
import '../src/model/Cliente.dart';

class WidgetsPerzonalizados {
  WidgetsPerzonalizados();

  void showUser(context, Cliente cliente) async {
    Canino canino = Canino.c1();
    CollectionReference ref =
          FirebaseFirestore.instance.collection("Mascota");
      QuerySnapshot mascota = await ref.get();
       for (var c in mascota.docs) {
          if (cliente.id == c.id) {
            canino = Canino(c.id, cliente.id, c.get("nombre"), c.get("edad"),
                  c.get("id_raza"), c.get("estado"));;
          }
        }
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Consulta de usuario'),
          content: SingleChildScrollView(
              child: Profile(
                  imageUrl: "imageUrl",
                  usuario: cliente.usuario.toString(),
                  contrasena: cliente.contrasena.toString(),
                  nombre: cliente.nombre.toString(),
                  apellido: cliente.apellido.toString(),
                  genero: cliente.genero.toString(),
                  edad: cliente.edad.toString(),
                  rol: cliente.rol.toString(),
                  estado: cliente.estado.toString(),
                  nombreMascota: canino.nombre.toString(),
                  edadMascota: canino.edad.toString(),
                  )),
                  
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
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
