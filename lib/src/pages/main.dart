import 'package:DAAC_APP/src/pages/AdminHome.dart';
import 'package:DAAC_APP/src/pages/HomePage.dart';
import 'package:DAAC_APP/src/pages/Principal.dart';
import 'package:DAAC_APP/src/pages/Registro.dart';
import 'package:flutter/material.dart';
import 'package:DAAC_APP/src/pages/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';

import 'TimeToFeed.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Samd app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Principal.id,
      routes: {
        Principal.id: (context) => Principal(),
        LoginPage.id: (context) => LoginPage(),
        HomePage.id: (context) => HomePage(),
        Registro.id: (context) => Registro(),
        AdminHome.id: (context) => AdminHome(),
      },
    );
  }
}
