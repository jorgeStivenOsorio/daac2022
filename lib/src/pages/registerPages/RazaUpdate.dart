import 'package:DAAC_APP/src/pages/WindowsSize.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../widgetsPerzonalizados/DaacForms.dart';
import '../../model/Raza.dart';

class RazaUpdate extends StatefulWidget {
  static String id = "RazaUpdate";

  @override
  State<RazaUpdate> createState() => RazaUpdateState();
}

class RazaUpdateState extends State<RazaUpdate> {
  //Controladores de los textField del formulario
  TextEditingController descripcion = TextEditingController();

  //-------

  DaacForms forms = DaacForms();
  WindowsSize size = WindowsSize();
  final _formKey = GlobalKey<FormState>();
  final firebase = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final r = ModalRoute.of(context)!.settings.arguments as Raza?;
    Raza? raza = r;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text("Modificar cliente"),
      ),
      body: SingleChildScrollView(child: formRaza(raza!)),
    );
  }

  //Formulario de cliente
  Widget formRaza(Raza? raza) {
    descripcion = forms.textController(raza!.descripcion.toString());
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: size.heightSize(20, context)),
          forms.formFieldText("Nombre Usuario", context, descripcion),
          buttonSubmit(context, raza),
        ],
      ),
    );
  }

  //Agrega el usuario a la base de datos solo o con mascota.
  updateRaza(Raza? raza) async {
    try {
      await firebase.collection('Usuario').doc(raza!.id.toString()).set({
        "descripcion": descripcion.text,
        "estado": "activo",
      });
      Navigator.pop(context);
    } catch (e) {
      print("ERROR..." + e.toString());
    }
  }

  Widget buttonSubmit(context, Raza? raza) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Processing Data')));
            updateRaza(raza);
          } else {
            print("AH ocurrido un error, revise el form");
          }
        },
        child: Text('Modificar'),
      ),
    );
  }
}
