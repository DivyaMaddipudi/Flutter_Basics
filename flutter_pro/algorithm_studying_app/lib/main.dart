import 'package:flutter/material.dart';
import 'main_page.dart';
import 'dart:async';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    )
  );
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.push(
          context, MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      
      body: Center(
        
        child: Image.asset("assets/images/learn.png"),
        
        ),
    );
  }
}