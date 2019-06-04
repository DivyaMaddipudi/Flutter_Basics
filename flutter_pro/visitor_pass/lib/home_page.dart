import 'package:flutter/material.dart';
import 'package:visitor_pass/screen/mainscreen.dart';
import 'auth.dart';
import 'package:flutter/rendering.dart';


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
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Visitor Pass',
      theme: ThemeData(
      primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: new AppBar(
          title: new Text("Visitor Pass"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Logout", style: new TextStyle(fontSize: 17.0, color: Colors.white),),
              onPressed: _signOut,
            ),
          ],
        ),
        body: MainScreen(),
      ),
    );
  }
}