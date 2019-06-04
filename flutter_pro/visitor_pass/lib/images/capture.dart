import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CaptureImage extends StatefulWidget {
  @override
  _CaptureImageState createState() => _CaptureImageState();
}

class _CaptureImageState extends State<CaptureImage> {

  File _imageFile;
  bool _uploaded = false;
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
    return Scaffold(
      appBar: AppBar(
        title:  Text("Capture Image"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Camera"),
              onPressed: () {
                getImage(true);
              },
            ),
            _imageFile == null ? Container() :Image.file(
              _imageFile,
              height: 300.0,
              width: 300.0
              ),
              _imageFile == null ? Container() :RaisedButton(
                child: Text("Upload"),
                onPressed: () {
                  uploadImage();
                },
              ),
         ],
        )
      )
    );
  }
}