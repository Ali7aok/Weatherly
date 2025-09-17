import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,

progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Colors.blueGrey[700],
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black87),
    bodySmall: TextStyle(color: Colors.black54),
  ),
  iconTheme: IconThemeData(color: Colors.black87),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blueGrey[700],
    foregroundColor: Colors.white,
    
    
  ),
);