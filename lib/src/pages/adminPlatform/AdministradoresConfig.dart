import 'package:DAAC_APP/src/model/Administrador.dart';
import 'package:DAAC_APP/src/pages/WindowsSize.dart';
import 'package:DAAC_APP/src/pages/registerPages/AdminRegist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../widgetsPerzonalizados/WidgetsPerzonalizados.dart';
import '../registerPages/AdminUpdate.dart';

class AdministradoresConfig extends StatefulWidget {
  static String id = "AdministradoresConfig";

  @override
  State<AdministradoresConfig> createState() => AdministradoresConfigState();
}

class AdministradoresConfigState extends State<AdministradoresConfig> {
  WindowsSize size = WindowsSize();
  CollectionReference colection =
      FirebaseFirestore.instance.collection("Usuario");
  List<Administrador> administradores = [];
  WidgetsPerzonalizados wp = WidgetsPerzonalizados();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff4361ee),
          leading: const BackButton(
            color: Colors.white,
          ),
          title: const Text("Configuracion administradores"),
          actions: [
            TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed("login_page");
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  "Cerrar sesion",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffC2BBF0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminRegist(),
                        ),
                      );
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.add, color: Colors.white),
                          const Text("Nuevo")
                        ]),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: validateDatos(),
                    builder: (context, snapshot) {
                      return table();
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  table() {
    return DataTable(
      columnSpacing: 20,
      columns: const [
        DataColumn(label: Text("")),
        DataColumn(label: Text("")),
        DataColumn(label: Text("")),
        DataColumn(label: Text("Usuario")),
        DataColumn(
          label: Text("Nombre"),
        ),
        DataColumn(
          label: Text("Apellido"),
        ),
        DataColumn(
          label: Text("Edad"),
        ),
        DataColumn(
          label: Text("Genero"),
        ),
        DataColumn(
          label: Text("Rol"),
        ),
        DataColumn(
          label: Text("Estado"),
        ),
      ],
      rows: [
        for (var a in administradores)
          DataRow(selected: true, cells: [
            DataCell(
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffC2BBF0),
                  ),
                  // TODO:Boton editar
                  onPressed: () {
                    Administrador adm = Administrador(
                        a.id,
                        a.usuario,
                        a.contrasena,
                        a.nombre,
                        a.apellido,
                        a.genero,
                        a.edad,
                        a.rol,
                        a.estado);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminUpdate(),
                        settings: RouteSettings(
                          arguments: adm,
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.edit,
                    size: 20,
                  )),
            ),
            DataCell(
              ElevatedButton(
                  onPressed: () {
                    wp.deleteAlertDialog(context, colection.doc(a.id));
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.delete,
                    size: 20,
                  )),
            ),
            DataCell(
              ElevatedButton(
                  onPressed: () {},
                  child: const Icon(
                    Icons.visibility,
                    size: 20,
                  )),
            ),
            DataCell(
              Text(a.usuario.toString()),
            ),
            DataCell(Text(a.nombre.toString())),
            DataCell(
              Text(a.apellido.toString()),
            ),
            DataCell(
              Text(a.edad.toString()),
            ),
            DataCell(
              Text(a.genero.toString()),
            ),
            DataCell(
              Text(a.rol.toString()),
            ),
            DataCell(
              Text(a.estado.toString()),
            ),
          ]),
      ],
    );
  }

  Future validateDatos() async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection("Usuario");
      QuerySnapshot usuario = await ref.get();

      for (var u in usuario.docs) {
        if (u.get("rol") == "administrador") {
          administradores.add(Administrador(
              u.id,
              u.get("usuario"),
              u.get("contraseña"),
              u.get("nombre"),
              u.get("apellido"),
              u.get("genero"),
              u.get("edad"),
              u.get("rol"),
              u.get("estado")));
        }
      }
      print(administradores.length);
    } catch (e) {
      print('ERROR...!!!' + e.toString());
    }
  }
}
