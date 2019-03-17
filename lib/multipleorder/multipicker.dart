//import 'dart:io';
//
//import 'package:adv_image_picker/adv_image_picker.dart';
//import 'package:flutter/material.dart';
//
////void main() => runApp(MyApp());
//
//class MultiPicker extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      theme: ThemeData(
//        primarySwatch: Colors.blueGrey,
//      ),
//      home: MyHomePage(title: '' ),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//  List<File> files = [];
//
//  void _pickImage() async {
//    files.addAll(await AdvImagePicker.pickImagesToFile(context));
//
//    setState(() {
//
//    });
//  }
//  String dropdownValue = 'Select Vote Type:';
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      resizeToAvoidBottomPadding: false,
//      appBar: new AppBar(
//        title: Row(
////          mainAxisAlignment: MainAxisAlignment.center,
//          children: [
//            Container(
//                padding: const EdgeInsets.all(8.0),
//                child: Center(
//                  child: DropdownButton<String>(
//                    value: dropdownValue,
//                    onChanged: (String newValue) {
//                      setState(() {
//                        dropdownValue = newValue;
//                      });
//                    },
//                    items: <String>['Select Vote Type:','Single Selection', 'Multiple Selection', 'Vote by Ordering']
//                        .map<DropdownMenuItem<String>>((String value) {
//                      return DropdownMenuItem<String>(
//                        value: value,
//                        child: Text(value,style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.grey[450]),),
//                      );
//                    })
//                        .toList(),
//                  ),
//                ))
//          ],
//        ),
//        backgroundColor: Colors.white,
//      ),
//
//      body: Center(
//        child: GridView.count(crossAxisCount: 3,
//          padding: const EdgeInsets.all(10.0),
//          mainAxisSpacing: 4.0,
//          crossAxisSpacing: 4.0,
//          children: files.map((File f) => Image.file(f, fit: BoxFit.cover,)).toList(),
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _pickImage,
//        child: Icon(Icons.add),
//        mini: true,
//      ),
//    );
//  }
//}