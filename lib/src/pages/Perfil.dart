import 'package:DAAC_APP/src/pages/Registro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PerfilPage extends StatefulWidget {
  static String id = "PerfilPage";

  @override
  State<PerfilPage> createState() => Perfil();
}

class Perfil extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text(
            "Detalles de perfil",
            style: GoogleFonts.getFont("Roboto",
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
                color: Colors.white),
          ),
          leading: const BackButton(
            color: Colors.white,
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Registro()),
                  );
                },
                child: const Text(
                  "editar",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ))
          ],
        ),
        body: Container(
          child: (Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30.0,
                ),
                profileImage('images/fotoPerfil.jpg'),
                const SizedBox(
                  height: 60.0,
                ),
                Container(
                  height: 470.0,
                  width: 350.0,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        containerRow("Nombre", "Stiven"),
                        separator(),
                        containerRow("Apellido", "Osorio"),
                        separator(),
                        containerRow("Edad", "25 años"),
                        separator(),
                        containerRow("Ciudad", "Medellin"),
                        separator(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Mascota",
                              style: GoogleFonts.merriweather(
                                  fontSize: 30.0,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                            petImage("images/mascota.jpg")
                          ],
                        ),
                        separator(),
                        containerRow("Nombre", "Firulais"),
                        separator(),
                        containerRow("Raza", "Frespuder"),
                        separator(),
                        containerRow("Edad", "24 meses"),
                        separator(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  Widget circulo() {
    return SizedBox.fromSize(
      size: Size(140, 140), // button width and height
      child: ClipOval(
        child: Material(
          color: Colors.black12, // button color
          child: InkWell(
            splashColor: Colors.blue, // splash color
            onTap: () {}, // button pressed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "images/logoBoton.png",
                  width: 90.0,
                ), // icon
                Text(
                  "Dispensar",
                  textAlign: TextAlign.center,
                ), // text
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget separator() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        color: Colors.grey[300],
        height: 1.0,
        width: 340.0,
      ),
    );
  }

  Widget verticalSeparation() {
    return const SizedBox(
      height: 20.0,
    );
  }

  Widget containerRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.merriweather(
              fontSize: 17.0,
              color: Colors.black87,
              fontWeight: FontWeight.bold),
        ),
        Text(value,
            style: GoogleFonts.merriweather(fontSize: 17.0, color: Colors.blue))
      ],
    );
  }

  Widget profileImage(String imageRoot) {
    return Container(
      height: 120.0,
      width: 120.0,
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
              color: Colors.black, offset: Offset(0.0, 0.75), blurRadius: 5.0)
        ],
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(imageRoot),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget petImage(String imageRoot) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        height: 90.0,
        width: 90.0,
        decoration: rounedContShadow(imageRoot),
      ),
    );
  }

  BoxDecoration rounedContShadow(String imageRoot) {
    return BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(imageRoot),
        ),
        color: Colors.white);
  }
}
