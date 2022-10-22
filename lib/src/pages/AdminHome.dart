import 'package:DAAC_APP/src/pages/adminPlatform/AdministradoresConfig.dart';
import 'package:DAAC_APP/src/pages/WindowsSize.dart';
import 'package:DAAC_APP/src/pages/adminPlatform/RazaConfig.dart';
import 'package:flutter/material.dart';
import 'adminPlatform/ClientesConfig.dart';

class AdminHome extends StatefulWidget {
  static String id = "AdminHome";

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  WindowsSize size = WindowsSize();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          leading: const BackButton(
            color: Colors.white,
          ),
          title: Text("Administrador"),
        ),
        body: Stack(
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
            SizedBox(
              height: size.heightSize(500, context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: FloatingActionButton.extended(
                      heroTag: "Administradores",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdministradoresConfig()),
                        );
                      },
                      label: Text(
                        "Administradores",
                        style: TextStyle(color: Colors.brown, fontSize: 16),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 15,
                    ),
                  ),
                  SizedBox(
                    child: FloatingActionButton.extended(
                      heroTag: "Clientes",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClientesConfig()),
                        );
                      },
                      label: Text(
                        "Clientes",
                        style: TextStyle(color: Colors.brown, fontSize: 16),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 15,
                    ),
                  ),
                  SizedBox(
                    child: FloatingActionButton.extended(
                      heroTag: "Dispensadores",
                      onPressed: () {/* 
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        ); */
                      },
                      label: Text(
                        "Dispensadores",
                        style: TextStyle(color: Colors.brown, fontSize: 16),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 15,
                    ),
                  ),
                  SizedBox(
                    child: FloatingActionButton.extended(
                      heroTag: "Razas",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RazaConfig()),
                        );
                      },
                      label: Text(
                        "Razas",
                        style: TextStyle(color: Colors.brown, fontSize: 16),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
