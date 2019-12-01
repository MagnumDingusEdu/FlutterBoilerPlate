import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magnumdingus/navigatorUI.dart';
void main() {
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  );
  return runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.redAccent,
        brightness: Brightness.dark,
      ),
      title: "Flutter Boiler Plate",
      home: HomeApp(),
    );
  }
}