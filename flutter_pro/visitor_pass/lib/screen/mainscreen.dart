import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _autovalidate = false;
  String name,email,phonenumber,purpose,image;
  File _imageFile;
  bool _uploaded = false;
  String filepath;

StorageReference _reference = FirebaseStorage.instance.ref().child("myimage.jpg");

  Future getImage (bool isCamera) async {
    File image;
    if(isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    }
    setState(() {
     _imageFile = image; 
    });
  }

  Future uploadImage() async {

    
    StorageUploadTask uploadTask = _reference.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    setState(() {
     _uploaded = true; 
    });

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        decoration: InputDecoration(labelText: "Visitor Name",
        hintText: "Enter Visitor's Name"),
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
      SizedBox(
        width: 375,
       child: RaisedButton(
         onPressed: _sendToServer, child: Text("SUBMIT"),
       ),
      ),
        SizedBox(
        width: 375,      
        child: RaisedButton(
              child: Text("CAPTURE IMAGE"),
              onPressed: () {
                getImage(true);
              },
       )
      ),
            _imageFile == null ? Container() :Image.file(
              _imageFile,
              height: 300.0,
              width: 400.0
              ),
              _imageFile == null ? Container() : SizedBox(width: 375,
              child: RaisedButton(
                child: Text("UPLOAD"),
                onPressed: () {
                  uploadImage();
                },
              ),
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
      "purpose": purpose,
      "image": image
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