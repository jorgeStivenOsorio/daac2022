import 'package:DAAC_APP/src/model/Cliente.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class ClienteService {
  Future<List<Cliente>> getClientes() async {
    List<Cliente> misClientes = [];

    try {
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('Usuario').get();
      if (snapshot.exists) {
        for(DataSnapshot s in snapshot.children){

          print(s.value.toString());

        }
      } else {
        print('No data available.');
      }
      return misClientes;
    } catch (e) {
      return misClientes;
    }
  }
}
