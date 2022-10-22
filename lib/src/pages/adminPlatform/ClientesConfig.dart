import 'package:DAAC_APP/src/model/Cliente.dart';
import 'package:DAAC_APP/src/pages/Registro.dart';
import 'package:DAAC_APP/src/pages/WindowsSize.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../widgetsPerzonalizados/WidgetsPerzonalizados.dart';
import '../registerPages/ClienteUpdate.dart';

class ClientesConfig extends StatefulWidget {
  static String id = "AdministradoresConfig";

  @override
  State<ClientesConfig> createState() => ClientesConfigConfigState();
}

class ClientesConfigConfigState extends State<ClientesConfig> {
  WindowsSize size = WindowsSize();
  CollectionReference colection =
      FirebaseFirestore.instance.collection("Usuario");
  List<Cliente> clientes = [];
  late Cliente cliente;
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
                        builder: (context) => Registro(),
                      ),
                    );
                        
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          Text("Nuevo")
                        ]
                      ) ,
                      ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: fillingClientList(),
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

  Widget table() {
    return DataTable(
      columnSpacing: 20,
      columns: [
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
        for (var a in clientes)
          DataRow(selected: true, cells: [
            DataCell(
              ElevatedButton(
                  onPressed: () {
                    Cliente Cli = Cliente(
                        a.id,
                        a.usuario,
                        a.contrasena,
                        a.nombre,
                        a.apellido,
                        a.genero,
                        a.edad,
                        a.rol,
                        a.m_nombre,
                        a.m_edad,
                        a.m_raza,
                        a.estado);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClienteUpdate(),
                        settings: RouteSettings(
                          arguments: Cli,
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
                    
                    wp.deleteAlertDialog(context,colection.doc(a.id));
                    fillingClientList();
                  },
                  child: Icon(
                    Icons.delete,
                    size: 20,
                  )),
            ),
            DataCell(
              ElevatedButton(
                  onPressed: () {
                    wp.showUser(context,a);
                  },
                  child: Icon(
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

  Future fillingClientList() async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection("Usuario");
      QuerySnapshot usuario = await ref.get();

      for (var u in usuario.docs) {
        if (u.get("rol") == "cliente") {
          print("1");
          clientes.add(Cliente(
              u.id,
              u.get("usuario"),
              u.get("contraseña"),
              u.get("nombre"),
              u.get("apellido"),
              u.get("genero"),
              u.get("edad"),
              u.get("rol"),
              u.get("m_nombre"),
              u.get("m_edad"),
              u.get("m_raza"),
              u.get("estado")));
        }
      }
    } catch (e) {
      print('ERROR...!!! fillingClientList' + e.toString());
    }
  }
}
