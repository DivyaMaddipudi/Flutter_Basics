import 'package:flutter/material.dart';

import 'package:qr_code/screens/home_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR code demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}