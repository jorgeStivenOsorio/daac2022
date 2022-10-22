import 'package:DAAC_APP/src/pages/WindowsSize.dart';
import 'package:flutter/material.dart';

class ClienteConfig extends StatefulWidget {
  static String id = "ClienteConfig";

  @override
  State<ClienteConfig> createState() => _ClienteConfigState();
}

class _ClienteConfigState extends State<ClienteConfig> {
  WindowsSize size = WindowsSize();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          leading: const BackButton(
            color: Colors.white,
          ),
          title: Text("Configuracion clientes"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 20,
            columns: [
              DataColumn(
                label: Text("Usuario"),
              ),
              DataColumn(label: Text("Nombre")),
              DataColumn(
                label: Text("Apellido"),
              ),
              DataColumn(
                label: Text(""),
              ),
              DataColumn(
                label: Text(""),
              ),
              DataColumn(
                label: Text(""),
              ),
            ],
            rows: [
              DataRow(selected: true, cells: [
                DataCell(
                  Text("Cruz2207"),
                ),
                DataCell(Text("andres")),
                DataCell(Text("activo")),
                DataCell(
                  ElevatedButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.edit,
                        size: 20,
                      )),
                ),
                DataCell(
                  ElevatedButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.delete,
                        size: 20,
                      )),
                ),
                DataCell(
                  ElevatedButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.visibility,
                        size: 20,
                      )),
                )
              ]),
              DataRow(cells: [
                DataCell(Text("Ramos22")),
                DataCell(Text("carlos")),
                DataCell(Text("Activo")),
                DataCell(
                  ElevatedButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.edit,
                        size: 20,
                      )),
                ),
                DataCell(
                  ElevatedButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.delete,
                        size: 20,
                      )),
                ),
                DataCell(
                  ElevatedButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.visibility,
                      size: 20,
                    ),
                  ),
                )
              ])
            ],
          ),
        ));
  }
}
