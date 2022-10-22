import 'package:DAAC_APP/src/pages/WindowsSize.dart';
import 'package:DAAC_APP/src/pages/registerPages/AdminRegist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../widgetsPerzonalizados/WidgetsPerzonalizados.dart';
import '../../model/Raza.dart';
import '../registerPages/AdminUpdate.dart';

class RazaConfig extends StatefulWidget {
  static String id = "AdministradoresConfig";

  @override
  State<RazaConfig> createState() => RazaConfigState();
}

class RazaConfigState extends State<RazaConfig> {
  WindowsSize size = WindowsSize();
  CollectionReference colection =
      FirebaseFirestore.instance.collection("Usuario");
  List<Raza> razas = [];
  WidgetsPerzonalizados wp = WidgetsPerzonalizados();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
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
                    style: ButtonStyle(),
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
                          Icon(Icons.add, color: Colors.white),
                          Text("Nuevo")
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
        DataColumn(label: Text("Raza")),
        DataColumn(
          label: Text("estado"),
        ),
      ],
      rows: [
        for (var r in razas)
          DataRow(selected: true, cells: [
            DataCell(
              ElevatedButton(
                  // TODO:Boton editar
                  onPressed: () {
                    Raza ra = Raza(r.id, r.descripcion, r.estado);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminUpdate(),
                        settings: RouteSettings(
                          arguments: ra,
                        ),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.edit,
                    size: 20,
                  )),
            ),
            DataCell(
              ElevatedButton(
                  onPressed: () {
                    wp.deleteAlertDialog(context, colection.doc(r.id));
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
              Text(r.descripcion.toString()),
            ),
            DataCell(Text(r.estado.toString())),
          ]),
      ],
    );
  }

  Future validateDatos() async {
    try {
      CollectionReference ref = FirebaseFirestore.instance.collection("Raza");
      QuerySnapshot rs = await ref.get();

      for (var u in rs.docs) {
        razas.add(Raza(u.id, u.get("descripcion"), u.get("estado")));
      }
    } catch (e) {
      print('ERROR...!!!' + e.toString());
    }
  }
}
