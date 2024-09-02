import 'package:flutter/material.dart';

class Colour {
  static const dark = Colors.black;
  static const white = Colors.white;
  static const blue = Colors.blue;
  static const darkWhite = Color.fromARGB(227, 191, 184, 184);
  static const darkBlue = Color.fromARGB(255, 20, 91, 150);
  static const green = Colors.green;
  static const red = Color.fromARGB(255, 223, 97, 88);
}

const customTextStyle = TextStyle(
  backgroundColor: Colour.white,
  color: Colour.dark,
  fontSize: 25,
  fontWeight: FontWeight.w500,
);
