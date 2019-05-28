import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:flutter/rendering.dart';
import 'package:visitor_pass/screen/HomeScreen.dart';
import 'package:visitor_pass/screen/SplashScreen.dart';
import 'package:visitor_pass/constant/constant.dart';


class HomePage extends StatelessWidget {
  HomePage({this.auth,this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signOut() async {
    try{
      await auth.signOut();
      onSignedOut();
    } catch (e) {
        print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Welcome"),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Logout", style: new TextStyle(fontSize: 17.0, color: Colors.white),),
            onPressed: _signOut,
          )
        ],
      ),
    );
     new MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    title: 'QR GENERATOR',
    routes: <String, WidgetBuilder>{
      HOME_SCREEN: (BuildContext context) => HomeScreen(),
    },
    home: SplashScreen(),
    );
  }
}