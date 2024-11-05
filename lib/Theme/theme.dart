import 'package:flutter/material.dart';

class MyInputDecorationTheme {
  // A method that returns InputDecorationTheme to pass it to the inputDecorationTheme
  // property of the ThemeData Class  in main.dart
  InputDecorationTheme myInputDecorationTheme() => InputDecorationTheme(
      // by making this property tru , the label of the TextFormField will
      //ALWAYS float to the top of the field with a nice animation
      floatingLabelBehavior: FloatingLabelBehavior.always,

      // specify the shape and color of the border of the TextFormField
      disabledBorder: _buildOutlineInputBorder(Colors.blueGrey),
      enabledBorder: _buildOutlineInputBorder(const Color(0xFF4C8D5F)),
      focusedBorder: _buildOutlineInputBorder(const Color(0xFF4C8D5F)),
      errorBorder: _buildOutlineInputBorder(Colors.red),
      focusedErrorBorder: _buildOutlineInputBorder(Colors.orangeAccent),
      errorStyle: _buildTextStyle(Colors.red),
      iconColor: const Color(0xFF4C8D5F),
      focusColor: const Color(0xFF4C8D5F),
      prefixIconColor: const Color(0xFF4C8D5F),
      labelStyle: const TextStyle(color: Color(0xFF4C8D5F)),
      suffixIconColor: const Color(0xFF4C8D5F));

  OutlineInputBorder _buildOutlineInputBorder(Color color) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: color,
          width: 1,
        ),
      );

  TextStyle _buildTextStyle(Color color, {double fontSize = 16}) => TextStyle(
        color: color,
        fontSize: fontSize,
      );
}
