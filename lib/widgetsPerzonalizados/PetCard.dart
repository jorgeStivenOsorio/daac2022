import 'package:flutter/material.dart';

import '../src/model/Canino.dart';
import '../src/model/Cliente.dart';
import '../src/pages/WindowsSize.dart';
import 'DaacForms.dart';

class PetCard {
  PetCard();

  WindowsSize size = WindowsSize();
  DaacForms forms = DaacForms();

  Widget petCard0(context, Cliente cliente, razas, data) {
    Canino can = Canino.const1();

    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: InkWell(
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Color.fromARGB(255, 240, 240, 240),
              child: SizedBox(
                  height: size.heightSize(70, context),
                  width: size.width(context) - 40,
                  child: pet(context, data, cliente))),
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: ((context) {
                  return forms.formPet(context, razas);
                }));
          },
        ));
  }

  pet(context, data, cliente) {
    if (data) {
      return Center(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.8),
              child: Image.asset(
                "images/perro.png",
                height: 40,
                width: 40,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cliente.m_nombre.toString(),
                  style: TextStyle(fontSize: 18),
                ),
                Text(cliente.m_edad.toString(), style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      );
    } else {
      return Center(
          child: Text("Agrega tu mascota",
              style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 83, 83, 83),
              )));
    }
  }

  Widget petCard(context, cliente, canino, razas) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: InkWell(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Color.fromARGB(255, 240, 240, 240),
          child: SizedBox(
            height: size.heightSize(70, context),
            width: size.width(context) - 40,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.8),
                  child: Image.asset(
                    "images/perro.png",
                    height: 40,
                    width: 40,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      canino.nombre.toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(canino.edad.toString(),
                        style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: ((context) {
                return forms.formPetUpdate(cliente, context, razas);
              }));
        },
      ),
    );
  }
}
