
import 'package:flutter/material.dart' show BuildContext, MediaQuery, Size;

class WindowsSize {

  WindowsSize();

  double heightSize (double num, BuildContext context){
    var mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    double porcent = (num * 100) / size.height;
    return (size.height * porcent)/100;
  }

  double widthSize (double num, BuildContext context){
    var mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    double porcent = (num * 100) / size.width;
    return (size.width * porcent)/100;
  }

  double width (BuildContext context){
    var mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    return size.width;
  }

  double heigth (BuildContext context){
    var mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    return size.height;
  }



}

