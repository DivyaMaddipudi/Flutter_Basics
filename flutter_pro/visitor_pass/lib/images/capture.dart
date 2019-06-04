import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CaptureImage extends StatefulWidget {
  @override
  _CaptureImageState createState() => _CaptureImageState();
}

class _CaptureImageState extends State<CaptureImage> {

  File file;
  bool _uploaded = false;
  String filepath;
//StorageReference _reference = FirebaseStorage.instance.ref().child("myimage.jpg");

  Future getImage (bool isCamera) async {
    File image;
    if(isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    }
    setState(() {
     file = image; 
    });
  }

  Future uploadImage() async {
    final ByteData bytes = await rootBundle.load(filepath);
    final Directory tempDir = Directory.systemTemp;
    final String fileName = "${Random().nextInt(10000)}.jpg";
    final File file = File("${tempDir.path}/$fileName");
    file.writeAsBytes(bytes.buffer.asInt8List(), mode: FileMode.write);

    final StorageReference _reference = FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask uploadTask = _reference.putFile(file);
    final StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;  
    var downloadURL = (await uploadTask.onComplete).ref.getDownloadURL();
    var _path = downloadURL.toString();

        print(_path);

    
    //StorageUploadTask uploadTask = _reference.putFile(_imageFile);
    //StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

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
            file == null ? Container() :Image.file(
              file,
              height: 300.0,
              width: 400.0
              ),
              file == null ? Container() :RaisedButton(
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