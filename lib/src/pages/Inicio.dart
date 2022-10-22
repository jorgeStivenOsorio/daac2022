import 'package:flutter/material.dart';


class InicioPage extends StatefulWidget {

  static String id = "InicioPage";

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Hola"),
    );
  }
}