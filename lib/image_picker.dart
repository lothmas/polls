import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medias_picker/medias_picker.dart';

//void main() => runApp(new MyApp());

class ImagePickers extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<ImagePickers> {
  String _platformVersion = 'Unknown';
  List<dynamic> docPaths;
  @override
  initState() {
    super.initState();
  }

  pickImages() async {
    try {

      docPaths = await MediasPicker.pickImages(quantity: 1, maxWidth: 1024, maxHeight: 1024, quality: 85);

      String firstPath = docPaths[0] as String;

      List<dynamic> listCompressed = await MediasPicker.compressImages(imgPaths: [firstPath], maxWidth: 600, maxHeight: 600, quality: 100);
      print(listCompressed);

    } on PlatformException {

    }

    if (!mounted)
      return;

    setState(() {
      _platformVersion = docPaths.toString();
    });
  }

  pickVideos() async {
    try {
      docPaths = await MediasPicker.pickVideos(quantity: 1);
    } on PlatformException {

    }

    if (!mounted)
      return;

    setState(() {
      _platformVersion = docPaths.toString();
    });
  }


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Plugin example app'),
        ),
        body: new Center(
          child: new Row(
            children: <Widget>[
              new IconButton(
                icon: Icon(Icons.image),
                onPressed: () {
                  pickImages();
                },
              ),
              new IconButton(
                icon: Icon(Icons.image),
                onPressed: () {
                  pickVideos();
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}