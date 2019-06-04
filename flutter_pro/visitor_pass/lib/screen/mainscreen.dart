import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:visitor_pass/images/capture.dart';
import 'package:visitor_pass/screen/showdata.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _autovalidate = false;
  String name,email,phonenumber,purpose;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: _key,
              autovalidate: _autovalidate,
              child: formUI(),
            ),
          ),
        ),
    );
  }
  Widget formUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        
       TextFormField(
        decoration: InputDecoration(labelText: "Name",
        hintText: "Enter Name"),
        onSaved: (val) {
          name = val;
        },
        validator: validateName,
        maxLength: 50,
       ),
       TextFormField(
        decoration: InputDecoration(labelText: "Email",
          hintText: "Enter Email"),
        onSaved: (val) {
          email = val;
        },
        validator: validateEmail,
        maxLength: 100,
       ),

       TextFormField(
        decoration: InputDecoration(labelText: "PhoneNumber",
        hintText: "Enter PhoneNumber"),
        keyboardType: TextInputType.number,
        onSaved: (val) {
          phonenumber = val;
        },
        validator: validatePhonenumber,
        maxLength: 10,
       ),

       TextFormField(
        decoration: InputDecoration(labelText: "Purpose",
        hintText: "Enter Purpose"),
        onSaved: (val) {
          purpose = val;
        },
        validator: validatePurpose,
        maxLines: 5,
        maxLength: 256,
       ),
      Center(
       child: RaisedButton(
         onPressed: _sendToServer, child: Text("SUBMIT"),
       ),
      ),
      Center(
        child: RaisedButton(
         onPressed: () {
           Navigator.push(context, 
              MaterialPageRoute(builder: (context) => CaptureImage()));
         },
         child: Text("Capture Image"),
       )
      ),
      ],
    );
  }

_sendToServer() {
  if(_key.currentState.validate()) {
    _key.currentState.save();
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data ={
      "name": name,
      "email": email,
      "phonenumber": phonenumber,
      "purpose": purpose
    };
    ref.child('Visitors').push().set(data).then((v){
      _key.currentState.reset();
    });
  } else {
    setState(() {
     _autovalidate = true; 
    });
  }

}

String validateName(String val) {
  return val.length == 0 ? "Enter Name First" : null;
}

String validateEmail(String val) {
  return val.length == 0 ? "Enter Email First" : null;
}
String validatePhonenumber(String val) {
  return val.length == 0 ? "Enter Phonenumber First" : null;
}
String validatePurpose(String val) {
  return val.length == 0 ? "Enter Purpose First" : null;
  }
}