import 'package:flutter/material.dart';

import 'package:flutter_tags/input_tags.dart';
import 'package:flutter_tags/selectable_tags.dart';

//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
//      title: 'Flutter Demo',
//      theme: ThemeData(
//
//        primarySwatch: Colors.blueGrey,
//      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
//  TabController _tabController;
  ScrollController _scrollViewController;

  bool _symmetry = true;
  int _column = 4;
  double _fontSize = 12;

  String _inputOnPressed = '';

  List<String> _inputTags = [];

  @override
  void initState() {
    super.initState();
//    _tabController = TabController(length: 2, vsync: this);
    _scrollViewController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,

        body: ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Text('Text Nominees',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(10),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: InputTags(
            placeholder: "Add a Nominee",
            color: null,
            autofocus: false,
            tags: _inputTags,
            columns: _column,
            fontSize: _fontSize,
            symmetry: _symmetry,
            lowerCase: true,
            onDelete: (tag) {
              print(tag);
            },
            onInsert: (tag) {
              print(tag);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(_inputOnPressed),
        ),
      ],
    ));
  }


}
