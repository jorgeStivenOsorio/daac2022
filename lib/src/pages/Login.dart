import 'package:DAAC_APP/src/pages/AdminHome.dart';
import 'package:DAAC_APP/src/pages/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:DAAC_APP/src/pages/windowsSize.dart';
import 'package:DAAC_APP/src/pages/perfil.dart';
import 'HomePage.dart';

class LoginPage extends StatefulWidget {
  static String id = "login_page";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Perfil perfil = Perfil();
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  late String ruteLogin;

  

  @override
  Widget build(BuildContext context) {
    WindowsSize size = WindowsSize();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: size.heightSize(320, context),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/background 3.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 250.0,
                  width: 250.0,
                  decoration: perfil.rounedContShadow("images/userLogo.png"),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: size.heightSize(100, context)),
              child: Column(
                children: [
                  SizedBox(
                    height: size.heightSize(45, context),
                  ),
                  _userTextField(),
                  SizedBox(
                    height: size.heightSize(40, context),
                  ),
                  _paswordTextField(),
                  SizedBox(
                    height: size.heightSize(50, context),
                  ),
                  _bottonLogin(),
                  SizedBox(
                    height: size.heightSize(60, context),
                  ),
                  _registerAndForgetPassword(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

validateDatos() async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection("Usuario");
      QuerySnapshot usuario = await ref.get();

      if (usuario.docs.isNotEmpty) {
        for (var u in usuario.docs) {
          if (u.get("usuario") == user.text &&
              u.get("contraseña") == pass.text) {
            if (u.get("rol") == "administrador") {
              print("********ROL -->" + u.get("rol"));
              ruteLogin = AdminHome.id;
            } else {
              ruteLogin = HomePage.id;
              print("rol cliente");
            }
          }
        }
        Navigator.of(context).pushNamed(ruteLogin);
      } else {
        print("No hay documentos en la conleccion");
      }
    } catch (e) {
      print('ERROR...' + e.toString());
    }
  }
  //Campo de usuario
  Widget _userTextField() {
    WindowsSize size = WindowsSize();
    double horizontal = size.widthSize(30, context);

    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
        ),
        child: TextField(
          controller: user,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              // Establece un borde cicular/otro  alrededor de la caja de texto
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
            ),
            icon: Icon(Icons.person),
            hintText: 'ejemplo@correo.com',
            labelText: 'Correo Electronico',
          ),
          onChanged: (value) {},
        ),
      );
    });
  }

  //Campo de contraseña
  Widget _paswordTextField() {
    WindowsSize size = WindowsSize();
    double horizontal = size.widthSize(30, context);

    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: horizontal),
        child: TextField(
          controller: pass,
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              // Establece un borde cicular/otro  alrededor de la caja de texto
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
            ),
            icon: Icon(
              Icons.lock,
            ),
            hintText: 'Contraseña',
            labelText: 'Contraseña',
          ),
          onChanged: (value) {},
        ),
      );
    });
  }

  Future<String> validateRol() async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection("Usuario");
      QuerySnapshot usuario = await ref.get();
      for (var u in usuario.docs) {
        if (u.get("rol") == "administrador") {
          print("admin");
          ruteLogin = "";
        } else {
          print("cliente");
          ruteLogin = "";
        }
      }
      return ruteLogin;
    } catch (e) {
      return "";
      print('ERROR...' + e.toString());
    }
  }

  //Boton de login
  Widget _bottonLogin() {
    WindowsSize size = WindowsSize();

    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return SizedBox(
        height: 80,
        width: 150,
        child: FloatingActionButton.extended(
          heroTag: "1",
          onPressed: () {
            validateDatos();
          },
          label: Text(
            "Iniciar sesion",
            style: TextStyle(color: Colors.brown, fontSize: 16),
          ),
          backgroundColor: Colors.white,
          elevation: 15,
        ),
      );
    });
  }

  //Botones de registrarse y olvide contraseña
  Widget _registerAndForgetPassword() {
    WindowsSize size = WindowsSize();
    double horizontal = size.widthSize(30, context);
    double vertical = size.heightSize(30, context);

    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Padding(
        padding: EdgeInsets.only(
            right: horizontal, left: horizontal, bottom: vertical),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              child: const Text("""¿Has olvidado tu
    contraseña?"""),
              onPressed: null,
            ),
          ],
        ),
      );
    });
  }
}
