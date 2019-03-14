import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:medias_picker/medias_picker.dart';

//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stats/MaterialSwitch.dart';
import 'package:stats/rangeSlide.dart';

//import 'package:material_switch/material_switch.dart';
import 'package:stats/search.dart';
import 'package:vertical_tabs/vertical_tabs.dart';
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
//    'Poll Winner',
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

  bool isAgeRange = false;
  bool isGender = false;
  bool isLocation = false;
  bool isPrivate = false;

  List<String> switchOptions = ["Male", "Female"];
  String selectedSwitchOption = "Male";

//  GoogleMapController mapController;

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
                expandedHeight: 0.3,
                floating: true,
                forceElevated: boxIsScrolled,
                bottom: TabBar(
                  isScrollable: false,
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
                        padding: EdgeInsets.all(0.1),
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
                          padding: EdgeInsets.all(2),
                          child: Divider(
                            color: Colors.blueGrey,
                          )),
                      Text("Poll Main Display",
                          style: new TextStyle(
                            fontSize: 11.0,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                          )),
                      new ListTile(
//                        leading: ),
                        title: Container(
                          color: Colors.transparent,
                          child: new Center(
                              child: new Row(
//                                    crossAxisAlignment: CrossAxisAlignment.sp,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      FlatButton.icon(
                                        color: Colors.blueGrey[200],
                                        icon: Icon(Icons.add_photo_alternate,color: Colors.blueGrey,),
                                        //`Icon` to display
                                        label: Text('Add a Photo',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 9),),
                                        //`Text` to display
                                        onPressed: () {
                                          pickImages();
                                          //Code to execute when Floating Action Button is clicked
                                          //...
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      FlatButton.icon(
                                        color: Colors.blueGrey[200],
                                        icon: Icon(Icons.video_library,color: Colors.blueGrey,),
                                        //`Icon` to display
                                        label: Text('Add a Video',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 9),),
                                        //`Text` to display
                                        onPressed: () {
                                          pickVideos();
                                          //Code to execute when Floating Action Button is clicked
                                          //...
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          )),
                        ),
                      ),
                      Container(
                          child: new Image.file(
                        new File(_platformVersion),
//                        height: 80,
//                        width: 400,
                      ))

                    ],
                  ),
                ],
              ),
              SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: VerticalTabs(
                          tabsWidth: 110,
                          tabs: <Tab>[
                            Tab(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 1),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.date_range),
                                    SizedBox(width: 10),
                                    Text(
                                      'Age-Range',
                                      style: TextStyle(fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 1),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.airline_seat_legroom_extra),
                                    SizedBox(width: 10),
                                    Text('Gender',
                                        style: TextStyle(fontSize: 11)),
                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 1),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.lock_outline),
                                    SizedBox(width: 10),
                                    Text('Private Poll',
                                        style: TextStyle(fontSize: 11)),
                                  ],
                                ),
                              ),
                            ),
//                            Tab(
//                              child: Container(
//                                margin: EdgeInsets.only(bottom: 1),
//                                child: Row(
//                                  children: <Widget>[
//                                    Icon(Icons.location_on),
//                                    SizedBox(width: 10),
//                                    Text('Location',
//                                        style: TextStyle(fontSize: 11)),
//                                  ],
//                                ),
//                              ),
//                            ),
                          ],
                          contents: <Widget>[
                            tabsContent(
                                Switch(
                                  value: isAgeRange,
                                  onChanged: (value) {
                                    setState(() {
                                      isAgeRange = value;
                                    });
                                  },
                                  activeTrackColor: Colors.blueGrey,
                                  activeColor: Colors.green,
                                ),
                                isAgeRange
                                    ? new RangeSliderItem(
                                        title: '',
                                        initialMinValue: 12,
                                        initialMaxValue: 100,
                                        onMinValueChanged: (v) {},
                                        onMaxValueChanged: (v) {},
                                      )
                                    : Text(
                                        'Enable to set Age-Range',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )),
                            tabsContent(
                              Switch(
                                value: isGender,
                                onChanged: (value) {
                                  setState(() {
                                    isGender = value;
                                  });
                                },
                                activeTrackColor: Colors.blueGrey,
                                activeColor: Colors.green,
                              ),
                              isGender
                                  ? MaterialSwitch(
                                      padding: const EdgeInsets.all(5.0),
                                      margin: const EdgeInsets.all(5.0),
                                      selectedOption: selectedSwitchOption,
                                      options: switchOptions,
                                      selectedBackgroundColor: isGender
                                          ? Colors.blueGrey
                                          : Colors.grey,
                                      selectedTextColor: isGender
                                          ? Colors.white
                                          : Colors.blueGrey,
                                      onSelect: isGender
                                          ? (String selectedOption) {
                                              setState(() {
                                                selectedSwitchOption =
                                                    selectedOption;
                                              });
                                            }
                                          : null,
                                    )
                                  : Text(
                                      'Enable to set Gender',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                            tabsContent(
                              Switch(
                                value: isPrivate,
                                onChanged: (value) {
                                  setState(() {
                                    isPrivate = value;
                                  });
                                },
                                activeTrackColor: Colors.blueGrey,
                                activeColor: Colors.green,
                              ),
                              isPrivate
                                  ? Container(
                                      width: 93.0,
                                      height: 25.0,
                                      child: FloatingActionButton.extended(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    new ExampleApp()),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.add_circle,
                                        ),
                                        label: Text("Add Voter",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold)),
                                      ))
                                  : Text(
                                      'Enable to set Private_Poll',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
//                            tabsContent(
//                              Switch(
//                                value: isLocation,
//                                onChanged: (value) {
//                                  setState(() {
//                                    isLocation = value;
//                                  });
//                                },
//                                activeTrackColor: Colors.blueGrey,
//                                activeColor: Colors.green,
//                              ),
//                              new Padding(
//                                padding: EdgeInsets.all(2.0),
//                                child: Column(
//                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                  children: <Widget>[
//                                    Center(
//                                      child: SizedBox(
//                                        width: 800.0,
//                                        height: 200.0,
//                                        child: GoogleMap(
//                                          onMapCreated: _onMapCreated,
//                                          initialCameraPosition: CameraPosition(
//                                            target: LatLng(35.715298, 	51.404343),
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//                                    RaisedButton(
//                                      child: const Text('Go to London'),
//                                      onPressed: mapController == null ? null : () {
//                                        mapController.animateCamera(CameraUpdate.newCameraPosition(
//                                          const CameraPosition(
//                                            bearing: 270.0,
//                                            target: LatLng(51.5160895, -0.1294527),
//                                            tilt: 30.0,
//                                            zoom: 17.0,
//                                          ),
//                                        ));
//                                      },
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  String _platformVersion = 'Unknown';
  List<dynamic> docPaths;

  pickImages() async {
    docPaths = await MediasPicker.pickImages(
        quantity: 1, maxWidth: 1024, maxHeight: 1024, quality: 85);

    String firstPath = docPaths[0] as String;

    List<dynamic> listCompressed = await MediasPicker.compressImages(
        imgPaths: [firstPath], maxWidth: 600, maxHeight: 600, quality: 100);
    print(listCompressed);

    setState(() {
      _platformVersion =
          docPaths.toString().replaceAll("[", "").replaceAll("]", "");
      // FocusScope.of(context).requestFocus(focusNode);
      String sf = "fds";
    });

    if (!mounted) return;
  }

  pickVideos() async {
    docPaths = await MediasPicker.pickVideos(quantity: 1);

    setState(() {
      _platformVersion =
          docPaths.toString().replaceAll("[", "").replaceAll("]", "");
      //     FocusScope.of(context).requestFocus(focusNode);
      String sf = "fds";
    });

    if (!mounted) return;
  }

  Widget tabsContent(Widget switcher, Widget controller) {
    return Container(
      margin: EdgeInsets.all(1),
      padding: EdgeInsets.all(1),
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          switcher,
          Divider(
            height: 5,
            color: Colors.black45,
          ),
          controller,
        ],
      ),
    );
  }

  showGenderSnackBar(BuildContext context, String textMessage) {
    final SnackBar objSnackbar = new SnackBar(
      content: new Text(textMessage),
      backgroundColor: Colors.amber,
    );

    Scaffold.of(context).showSnackBar(objSnackbar);
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

//  void _onMapCreated(GoogleMapController controller) {
//    setState(() {
//      mapController = controller;
//    });
//  }
}
