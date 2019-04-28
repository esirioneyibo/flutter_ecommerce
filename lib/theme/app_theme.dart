import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  // This is the theme of your application.
  //
  // Try running your application with "flutter run". You'll see the
  // application has a blue toolbar. Then, without quitting the app, try
  // changing the primarySwatch below to Colors.green and then invoke
  // "hot reload" (press "r" in the console where you ran "flutter run",
  // or simply save your changes to "hot reload" in a Flutter IDE).
  // Notice that the counter didn't reset back to zero; the application
  // is not restarted.
  backgroundColor: Colors.grey[300],
  primaryColor: Colors.pink[900],
  accentColor: Colors.red[500],
  textTheme: TextTheme(
    headline: TextStyle(
      fontSize: 35.0,
      fontWeight: FontWeight.bold,
      color: Colors.black54,
    ),
  ),
);

final BoxDecoration backgroundGradient = BoxDecoration(
  gradient: LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      stops: [0.1, 0.9],
      colors: [Colors.grey[400], Colors.grey[50]]),
);
