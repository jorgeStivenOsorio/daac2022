import 'package:DAAC_APP/src/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'Principal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:DAAC_APP/src/pages/CardFeed.dart';
import 'package:DAAC_APP/src/pages/WindowsSize.dart';

CardFeed card = CardFeed();
const List<Widget> daysOfWeek = <Widget>[
  Text('D'),
  Text('L'),
  Text('M'),
  Text('M'),
  Text('J'),
  Text('V'),
  Text('S'),
];

const List<Widget> portions = <Widget>[
  Text('1'),
  Text('2'),
  Text('3'),
  Text('4'),
  Text('5'),
];

class TimeToFeed extends StatefulWidget {
  static String id = "TimeToFeed";

  @override
  State<TimeToFeed> createState() => _timeToFeet();
}

class _timeToFeet extends State<TimeToFeed> {
  WindowsSize size = WindowsSize();
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool isPressed = false;
  int porcion = 0;
  List<Widget> cardsWidgets = [];
  List<CardFeed> cards = [];

  final List<bool> _selectedDays = <bool>[
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  final List<bool> _selectedportions = <bool>[
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    CardFeed card = CardFeed();
    return SafeArea(
        child: Scaffold(
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
            takeTime(),
            separator(),
            Row(
              children: [
                SizedBox(
                  width: size.widthSize(30, context),
                ),
                Text(
                  "Elija los dias",
                  style: GoogleFonts.roboto(
                    fontSize: size.heightSize(22.0, context),
                    fontStyle: FontStyle.italic,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: listOfDays(),
            ),
            separator(),
            Row(
              children: [
                SizedBox(
                  width: size.widthSize(30, context),
                ),
                Text(
                  "Porciones por servicio",
                  style: GoogleFonts.roboto(
                      fontSize: size.heightSize(22.0, context),
                      fontStyle: FontStyle.italic),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: listOfPortions(),
            ),
            Padding(
                padding: EdgeInsets.only(top: size.heightSize(30, context)),
                child: saveButton())
          ],
        ),
      ),
    ));
  }

//Boton de guardar etiqueta
  Widget saveButton() {
    card.estado = true;

    return ElevatedButton(
      onPressed: () {
        fullinCard();
        addCard();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
            settings: RouteSettings(
              arguments: card,
            ),
          ),
        );
      },
      child: Text("Guardar"),
      style: ButtonStyle(),
    );
  }

  //Llena la etiqueta
  fullinCard() {
    card.setDays(_selectedDays);
    for (int i = 0; i < _selectedportions.length; i++) {
      if (_selectedportions[i] == true) {
        card.setPortion(i + 1);
      }
    }
    card.setAction(true);
  }

  //Añade la etiqueta a la lista de etiquetas
  addCard() => cards.add(card);

  //Linea separadora
  Widget separator() {
    return Padding(
      padding: EdgeInsets.only(
          top: size.heightSize(14, context),
          bottom: size.heightSize(17, context)),
      child: Container(
        color: Colors.grey[300],
        height: size.heightSize(1, context),
        width: size.widthSize(370, context),
      ),
    );
  }

  //Botones para seleccionar cantidad de porciones
  Widget listOfPortions() {
    return ToggleButtons(
      direction: Axis.horizontal,
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < _selectedportions.length; i++) {
            _selectedportions[i] = i == index;
          }
        });
      },
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      selectedBorderColor: Colors.blue[700],
      selectedColor: Colors.white,
      fillColor: Colors.blue[200],
      color: Colors.blue[400],
      constraints: BoxConstraints(
        minHeight: size.heightSize(40.0, context),
        minWidth: size.widthSize(57.0, context),
      ),
      isSelected: _selectedportions,
      children: portions,
    );
  }

  //Botones para seleccionar los dias
  Widget listOfDays() {
    return ToggleButtons(
      direction: Axis.horizontal,
      onPressed: (int index) {
        // All buttons are selectable.
        setState(() {
          _selectedDays[index] = !_selectedDays[index];
        });
      },
      borderRadius: BorderRadius.circular(10),
      selectedBorderColor: Colors.blue[700],
      selectedColor: Colors.white,
      fillColor: Colors.blue[200],
      color: Colors.blue[400],
      constraints: BoxConstraints(
        minHeight: size.heightSize(40.0, context),
        minWidth: size.widthSize(40.0, context),
      ),
      isSelected: _selectedDays,
      children: daysOfWeek,
    );
  }

  //Muestra el seleccionador de hora y añade la hora seleccionada a la etiqueta.
  _showTimePicker(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: _selectedTime,
        initialEntryMode: TimePickerEntryMode.dial);
    if (timeOfDay != null && timeOfDay != _selectedDays) {
      setState(() {
        _selectedTime = timeOfDay;
        card.setTime(_selectedTime.format(context).toString());
      });
    }
  }

  //Widget interfaz para seleccionar hora.
  Widget takeTime() {
    String time;
    TimeOfDay selectedTime = TimeOfDay.now();

    return Center(
      child: Container(
        width: size.width(context),
        decoration: const BoxDecoration(
          color: Colors.lightBlueAccent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.heightSize(60, context),
            ),
            Text(
              "Fijar hora",
              style: GoogleFonts.roboto(
                  fontSize: 50,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.heightSize(20.0, context)),
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    _showTimePicker(context);
                  });
                },
                child: Text(
                  _selectedTime.format(context).toString(),
                  style:
                      GoogleFonts.roboto(fontSize: 60.0, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: size.heightSize(80, context),
            ),
          ],
        ),
      ),
    );
  }

  //Recibe lista de etiquetas y se encarga de crear y retornar la lista de widgets
  Widget etiquetas(BuildContext context, List<CardFeed> cards) {
    if (cards.length != 0) {
      return etiquetasW(cardsWidgets: cardsWidgets);
    } else {
      return Text("Agrege una etiqueta");
    }
  }

  //Se encarga de crear el widget de la etiqueta
  Widget card_(BuildContext context, CardFeed card) {
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
                      Text(card.getDays()),
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
                      card.action = index;
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
}

class etiquetasW extends StatelessWidget {
  final List<Widget> cardsWidgets;

  const etiquetasW({
    Key? key,
    required this.cardsWidgets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: cardsWidgets,
      ),
    );
  }
}
