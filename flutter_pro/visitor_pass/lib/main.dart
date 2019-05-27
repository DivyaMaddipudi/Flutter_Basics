import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
      return new MaterialApp(
        home: new VisitorPass(),
        theme: new ThemeData(
          primarySwatch: Colors.blue
        )
      );
  }
}

class VisitorPass extends StatefulWidget {
  @override
  State createState() => new VisitorPassState();
}
  
class VisitorPassState extends State<VisitorPass> {
  String _textString = "Hello Flutter";
  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[Text(_textString, style: TextStyle(fontSize: 30),
      ),
      RaisedButton(
        child: Text("Button"),
        onPressed: (){
          _doSomething();
          },
        ),
      ],
    );
  }
}

void _doSomething(){
  setState((){
        
      });
    }
  
  void setState(Null Function() param0) {
}
  

