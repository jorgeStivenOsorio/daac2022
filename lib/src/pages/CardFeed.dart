import 'package:flutter/material.dart';


class CardFeed {

  bool estado = false;
  String time = "";
  List<bool> days = [];
  int portions =0;
  bool action = true;
  List<String> dayList= ["D","L","M","M","J","V","S"];
  List<Widget> daysOfWeek = [
  Text('D'),
  Text('L'),
  Text('M'),
  Text('M'),
  Text('J'),
  Text('V'),
  Text('S'),
];


  CardFeed(){
    this.days=[false,true,true,true,true,true,false];
    this.time;
    this.portions;
    this.action;
    this.estado;
  }

  setDays(List<bool> days){
    this.days = days;
  }

  setTime(String time){
    this.time = time;
  }

  setPortion(int portions){
    this.portions = portions;
  }

  setAction(bool action){
    this.action = action;
  }


  String getDays(){
    String daysString="";
    if(dayList.length!=0){
      for (int i = 0; i<days.length;i++){
        if(days[i] = false){
          dayList.removeAt(i);
        }
      }
      for(int i = 0; i<dayList.length;i++){
        daysString += dayList[i];
      }
    }
    
    return daysString;
  }

  getTime(){return time;}

  getPortions(){return portions;}
  getAction(){return action;}




  @override
  String toString() {
    // TODO: implement toString
    return """dias:       ${days}
     Hora:       ${time}
     Porcioines:       ${portions}
     Estado:       ${action}
     """;
  }







}