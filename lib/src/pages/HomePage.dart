import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:DAAC_APP/src/pages/CardFeed.dart';
import 'package:DAAC_APP/src/pages/WindowsSize.dart';
import 'package:DAAC_APP/src/pages/perfil.dart';

import '../model/Cliente.dart';
import 'TimeToFeed.dart';

class HomePage extends StatefulWidget {
  static String id = "home_page";

  @override
  State<HomePage> createState() => _HomePague();
}

class _HomePague extends State<HomePage> {
  bool timeAsigned = true;
  TimeOfDay _timeOfDay = const TimeOfDay(hour: 8, minute: 30);
  List<Widget> cardsWidgets = [];
  List<CardFeed> cards = [];
  TextEditingController customController = TextEditingController();
  
  

  createAlertDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Your name?"),
            content: TextField(
              controller: customController,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    WindowsSize size = WindowsSize();
    print("este es!!!!");
    agregarCard();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          leading: const BackButton(
            color: Colors.white,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PerfilPage()),
                );
              },
              icon: const Icon(Icons.person),
              iconSize: size.heightSize(40.0, context),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: (Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                //parte superior (fondo y botones)
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.lightBlueAccent,
                        Colors.blue,
                      ],
                    )),
                    height: size.heightSize(220.0, context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.settings_sharp,
                          color: Colors.blue,
                          size: size.heightSize(40.0, context),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding:
                              EdgeInsets.all(size.heightSize(10.0, context)),
                          backgroundColor: Colors.white, // <-- Button color
                          foregroundColor: const Color.fromRGBO(
                              172, 141, 119, 1), // <-- Splash color
                        ),
                      ),
                      SizedBox(width: size.widthSize(30.0, context)),
                      manualFeedBoton(),
                      SizedBox(width: size.widthSize(30.0, context)),
                      ElevatedButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.menu_rounded,
                          color: Colors.blue,
                          size: size.heightSize(40.0, context),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding:
                              EdgeInsets.all(size.heightSize(10.0, context)),
                          backgroundColor: Colors.white, // <-- Button color
                          foregroundColor: const Color.fromRGBO(
                              172, 141, 119, 1), // <-- Splash color
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                  height: size.heightSize(350.0, context),
                  child: etiquetas(context, cards)),
              SizedBox(height: size.heightSize(25.0, context)),
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TimeToFeed()),
                  );
                },
                child: Icon(
                  Icons.add,
                  size: size.heightSize(30, context),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  agregarCard() {
    final cardArg = ModalRoute.of(context)!.settings.arguments as CardFeed?;

    if (cardArg != null) {
      final CardFeed cardArg_ = cardArg as CardFeed;
      if (cardArg_.estado != false) {
        cards.add(cardArg_);
        cardsWidgets.add(card(context, cardArg_));
        print("pase por aca");
        print(cardArg_.time);
      }
    }
  }

  Widget etiquetas(BuildContext context, List<CardFeed> cards) {
    if (cards.length != 0) {
      return etiquetasW(cardsWidgets: cardsWidgets);
    } else {
      return Text("Agrege una etiqueta");
    }
  }

  Widget card(BuildContext context, CardFeed card) {
    WindowsSize size = WindowsSize();
    return Center(
      child: Padding(
        padding: EdgeInsets.all(size.heightSize(20.0, context)),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blue[50], borderRadius: BorderRadius.circular(15)),
          width: size.widthSize(350.0, context),
          height: size.heightSize(90.0, context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(size.heightSize(11.0, context)),
                child: MaterialButton(
                  onPressed: () {},
                  child: Column(
                    children: [
                      Text(
                        card.time,
                        style: const TextStyle(fontSize: 25.0),
                      ),
                      Text(card
                          .getDays()), //---------------------------------------------------------------
                      Text(card.portions.toString()),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(size.heightSize(15.0, context)),
                child: Switch(
                  value: card.action,
                  onChanged: (index) {
                    setState(() {
                      card.action = !card.action;
                    });
                  },
                  activeColor: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget manualFeedBoton() {
    WindowsSize size = WindowsSize();
    return Container(
      height: size.heightSize(140.0, context),
      width: size.widthSize(140.0, context), // button width and height
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      child: ClipOval(
        child: Material(
          color: Colors.white, // button color
          child: InkWell(
            splashColor: Colors.blue, // splash color
            onTap: () {}, // button pressed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "images/logoBoton.png",
                  width: size.widthSize(90.0, context),
                ), // icon
                Text(
                  "manual",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(),
                ), // text
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget separator() {
    WindowsSize size = WindowsSize();
    return Padding(
      padding: EdgeInsets.all(size.heightSize(14.0, context)),
      child: Container(
        color: Colors.grey[300],
        height: size.heightSize(1.0, context),
        width: size.widthSize(340.0, context),
      ),
    );
  }

  void _showTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }
}

class etiquetasW extends StatelessWidget {
  const etiquetasW({
    Key? key,
    required this.cardsWidgets,
  }) : super(key: key);

  final List<Widget> cardsWidgets;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: cardsWidgets,
    );
  }
}
