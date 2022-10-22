import 'package:DAAC_APP/src/pages/Login.dart';
import 'package:DAAC_APP/src/pages/Perfil.dart';
import 'package:DAAC_APP/src/pages/Registro.dart';
import 'package:DAAC_APP/src/pages/WindowsSize.dart';
import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  static String id = "principal";

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final List<String> _lista = ["Masculino", "Femenino"];
  var selectedItem;
  final _formKey = GlobalKey<FormState>();
  Perfil perfil = Perfil();
  WindowsSize size = WindowsSize();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: size.heigth(context),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/background 3.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 200),
                      child: Container(
                        height: 250.0,
                        width: 250.0,
                        decoration:
                            perfil.rounedContShadow("images/daacLogo.png"),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 80,
                          width: 150,
                          child: FloatingActionButton.extended(
                            heroTag: "iniciar sesion",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            label: Text(
                              "Iniciar sesion",
                              style:
                                  TextStyle(color: Colors.brown, fontSize: 16),
                            ),
                            backgroundColor: Colors.white,
                            elevation: 15,
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          width: 150,
                          child: FloatingActionButton.extended(
                            heroTag: "registrar",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Registro()),
                              );
                            },
                            label: Text(
                              "Registrar",
                              style:
                                  TextStyle(color: Colors.brown, fontSize: 16),
                            ),
                            backgroundColor: Colors.white,
                            elevation: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
