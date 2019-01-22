import 'package:flutter/material.dart';

import 'package:flutter_tags/input_tags.dart';
import 'package:flutter_tags/selectable_tags.dart';

//void main() => runApp(MyApp());


class VoteNeededData extends StatelessWidget
{
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


class MyHomePage extends StatefulWidget
{
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin
{
  TabController _tabController;
  ScrollController _scrollViewController;

  final List<String> _list = [
    'gender','location','race','age',
    'occupation','views',
  ];

  bool _symmetry = true;
  int _column = 4;
  double _fontSize = 12;

  String _selectableOnPressed = '';
  String _inputOnPressed = '';

  List<Tag> _selectableTags = [];
  List<String> _inputTags = [];

  List _icon=[
    Icons.home,
    Icons.language,
    Icons.headset
  ];

  @override
  void initState()
  {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollViewController = ScrollController();

    _list.forEach((item) =>
        _selectableTags.add(
            Tag(title: item, active: true,icon: (item=='0' || item=='1' || item=='2')? _icon[ int.parse(item) ]:null )
        )
    );


  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(

          body: TabBarView(
            controller: _tabController,
            children:  [
              ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[

                      Column(
                        children: <Widget>[
                          Text('Poll Statistics To Produce',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Container(
                        child: SelectableTags(
                          tags: _selectableTags,
                          columns: _column,
                          fontSize: _fontSize,
                          symmetry: _symmetry,
                          onPressed: (tag){
                            setState(() {
                              _selectableOnPressed = tag.toString();
                            });
                          },
                        ),
                      ),

                    ],
                  ),
                ],
              ),

            ],
          ));

  }


  List<DropdownMenuItem> _buildItems()
  {
    List<DropdownMenuItem> list = [];

    int count = 15;

    for(int i = 1; i < count; i++)
      list.add(
        DropdownMenuItem(
          child: Text(i.toString() ),
          value: i,
        ),
      );

    return list;
  }
}