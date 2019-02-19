import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:cupertino_range_slider/cupertino_range_slider.dart';
import 'package:flutter_tags/input_tags.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:stats/rangeSlide.dart';
import 'package:toggle_button/toggle_button.dart';
import 'package:material_switch/material_switch.dart';
//void main() => runApp(MyApp());

class Tags extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  final List<String> _list = [
    'Poll Winner',
    'Age',
    'Gender',
    'Race',
    'Location',
    'Nationality',
    'Marital-Status',
    'Intrested but Non-Participant',
    'Occupation',
    'Employment-Status',
    'Educational-Level',
  ];

  final List<String> _list1 = [
    'Location',
    'Age Range',
    'Race',
  ];

  bool _symmetry = false;
  bool _singleItem = false;
  int _column = 4;
  double _fontSize = 13;

  String _selectableOnPressed = '';
  String _inputOnPressed = '';

  List<Tag> _selectableTags = [];
  List<Tag> _selectableTags1 = [];

  List<String> _inputTags = [];

  List _icon = [Icons.home, Icons.language, Icons.headset];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollViewController = ScrollController();

    int cnt = 0;
    _list.forEach((item) {
      _selectableTags.add(Tag(
          id: cnt,
          title: item,
          active: (_singleItem) ? (cnt == 3 ? true : false) : true,
          icon: (item == '0' || item == '1' || item == '2')
              ? _icon[int.parse(item)]
              : null));
      cnt++;
    });

    _list1.forEach((item) {
      _selectableTags1.add(Tag(
          id: cnt,
          title: item,
          active: (_singleItem) ? (cnt == 3 ? true : false) : true,
          icon: (item == '0' || item == '1' || item == '2')
              ? _icon[int.parse(item)]
              : null));
      cnt++;
    });
  }

  bool isSwitched = false;
  bool isSwitched1 = false;
  bool isLocation = false;
  bool isPrivate = false;

  List<String> switchOptions = ["Male", "Female"];
  String selectedSwitchOption = "Male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                centerTitle: true,
                pinned: true,
                expandedHeight: 110.0,
                floating: true,
                forceElevated: boxIsScrolled,
                bottom: TabBar(
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: TextStyle(fontSize: 14.0),
                  tabs: [
                    Tab(text: "Expected Report Data"),
                    Tab(text: "Poll Restrictions"),
                  ],
                  controller: _tabController,
                ),
              )
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Container(
                        child: SelectableTags(
                          tags: _selectableTags,
                          columns: _column,
                          fontSize: _fontSize,
                          symmetry: _symmetry,
                          singleItem: _singleItem,
                          //activeColor: Colors.deepPurple,
                          //boxShadow: [],
                          //margin: EdgeInsets.symmetric(horizontal: 3, vertical: 6),
                          onPressed: (tag) {
                            setState(() {
                              _selectableOnPressed = tag.toString();
                            });
                          },
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(10),
                          child: Divider(
                            color: Colors.blueGrey,
                          )),
                    ],
                  ),
                ],
              ),
              LayoutBuilder(
                builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new Opacity(
                              opacity: 1.0,
                              child: new Container(
                                decoration: new BoxDecoration(
                                  border: Border.all(color: Colors.transparent),
                                  shape: BoxShape.rectangle,
                                  image: new DecorationImage(
                                    image: new AssetImage(
                                        "images/createVoteBack1.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                transform: new Matrix4.identity()..scale(1.0),
//                      width: size.width,
//                      height: size.height,
//        color: color ?? Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new ListTile(
                                      leading: Text("Age-Range",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontWeight: FontWeight.bold)),
                                      title: new ExpandablePanel(
                                        header: Switch(
                                          value: isSwitched,
                                          onChanged: (value) {
                                            setState(() {
                                              isSwitched = value;
                                            });
                                          },
                                          activeTrackColor: Colors.blueGrey,
                                          activeColor: Colors.green,
                                        ),
                                        expanded:  RangeSliderItem(
                                          title: '',
                                          initialMinValue: 12,
                                          initialMaxValue: 80,
                                          onMinValueChanged: (v){},
                                          onMaxValueChanged: (v){},
                                        ),
                                        tapHeaderToExpand: true,
                                        hasIcon: true,
                                      ),
                                    ),
                                    const Divider(
                                      height: 2.0,
                                    ),
                                  ],
                                ),
                              )),
                          new Opacity(
                              opacity: 1.0,
                              child: new Container(
                                decoration: new BoxDecoration(
                                  border: Border.all(color: Colors.transparent),
                                  shape: BoxShape.rectangle,
                                  image: new DecorationImage(
                                    image: new AssetImage(
                                        "images/createVoteBack1.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                transform: new Matrix4.identity()..scale(1.0),
//                      width: size.width,
//                      height: size.height,
//        color: color ?? Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new ListTile(
                                      leading: Text("Gender",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontWeight: FontWeight.bold)),
                                      title: new ExpandablePanel(
                                        header: Switch(
                                          value: isSwitched1,
                                          onChanged: (value) {
                                            setState(() {
                                              isSwitched1 = value;
                                            });
                                          },
                                          activeTrackColor: Colors.blueGrey,
                                          activeColor: Colors.green,
                                        ),
                                        expanded: MaterialSwitch(
                                          padding: const EdgeInsets.all(5.0),
                                          margin: const EdgeInsets.all(5.0),
                                          selectedOption: selectedSwitchOption,
                                          options: switchOptions,
                                          selectedBackgroundColor:
                                              Colors.blueGrey,
                                          selectedTextColor: Colors.white,
                                          onSelect: (String selectedOption) {
                                            setState(() {
                                              selectedSwitchOption =
                                                  selectedOption;
                                            });
                                          },
                                        ),
                                        tapHeaderToExpand: true,
                                        hasIcon: true,
                                      ),
                                    ),
                                    const Divider(
                                      height: 2.0,
                                    ),
                                  ],
                                ),
                              )),
                          new Opacity(
                              opacity: 1.0,
                              child: new Container(
                                decoration: new BoxDecoration(
                                  border: Border.all(color: Colors.transparent),
                                  shape: BoxShape.rectangle,
                                  image: new DecorationImage(
                                    image: new AssetImage(
                                        "images/createVoteBack1.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                transform: new Matrix4.identity()..scale(1.0),
//                      width: size.width,
//                      height: size.height,
//        color: color ?? Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new ListTile(
                                      leading: Text("Private Poll",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontWeight: FontWeight.bold)),
                                      title: new ExpandablePanel(
                                        header: Switch(
                                          value: isPrivate,
                                          onChanged: (value) {
                                            setState(() {
                                              isPrivate = value;
                                            });
                                          },
                                          activeTrackColor: Colors.blueGrey,
                                          activeColor: Colors.green,
                                        ),
                                        expanded: MaterialSwitch(
                                          padding: const EdgeInsets.all(5.0),
                                          margin: const EdgeInsets.all(5.0),
                                          selectedOption: selectedSwitchOption,
                                          options: switchOptions,
                                          selectedBackgroundColor:
                                          Colors.blueGrey,
                                          selectedTextColor: Colors.white,
                                          onSelect: (String selectedOption) {
                                            setState(() {
                                              selectedSwitchOption =
                                                  selectedOption;
                                            });
                                          },
                                        ),
                                        tapHeaderToExpand: true,
                                        hasIcon: true,
                                      ),
                                    ),
                                    const Divider(
                                      height: 2.0,
                                    ),
                                  ],
                                ),
                              )),
                          new Opacity(
                              opacity: 1.0,
                              child: new Container(
                                decoration: new BoxDecoration(
                                  border: Border.all(color: Colors.transparent),
                                  shape: BoxShape.rectangle,
                                  image: new DecorationImage(
                                    image: new AssetImage(
                                        "images/createVoteBack1.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                transform: new Matrix4.identity()..scale(1.0),
//                      width: size.width,
//                      height: size.height,
//        color: color ?? Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new ListTile(
                                      leading: Text("Location",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontWeight: FontWeight.bold)),
                                      title: new ExpandablePanel(
                                        header: Switch(
                                          value: isLocation,
                                          onChanged: (value) {
                                            setState(() {
                                              isLocation = value;
                                            });
                                          },
                                          activeTrackColor: Colors.blueGrey,
                                          activeColor: Colors.green,
                                        ),
                                        expanded: MaterialSwitch(
                                          padding: const EdgeInsets.all(5.0),
                                          margin: const EdgeInsets.all(5.0),
                                          selectedOption: selectedSwitchOption,
                                          options: switchOptions,
                                          selectedBackgroundColor:
                                          Colors.blueGrey,
                                          selectedTextColor: Colors.white,
                                          onSelect: (String selectedOption) {
                                            setState(() {
                                              selectedSwitchOption =
                                                  selectedOption;
                                            });
                                          },
                                        ),
                                        tapHeaderToExpand: true,
                                        hasIcon: true,
                                      ),
                                    ),
                                    const Divider(
                                      height: 2.0,
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          )),
    );
  }

  List<DropdownMenuItem> _buildItems() {
    List<DropdownMenuItem> list = [];

    int count = 15;

    for (int i = 1; i < count; i++)
      list.add(
        DropdownMenuItem(
          child: Text(i.toString()),
          value: i,
        ),
      );

    return list;
  }
}
