import 'package:flutter/material.dart';

class BaseMaterialApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Boiler",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Testing the basic view"),
          
        ),
        body: Center(
          child: Text("Hello World", style: TextStyle(fontSize: 18),),
        ),
      )
    );
  }
}