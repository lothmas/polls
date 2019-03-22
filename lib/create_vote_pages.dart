import 'dart:io';

import 'package:adv_image_picker/adv_image_picker.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/input_tags.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:intl/intl.dart';
import 'package:stats/MaterialSwitch.dart';
import 'package:stats/image_picker.dart';
import 'package:stats/main.dart';
import 'package:stats/multipleorder/multipicker.dart';
import 'package:stats/rangeSlide.dart';
import 'package:stats/search.dart';
import 'package:stats/tag.dart';
import 'package:stats/vote_by_dropdown.dart';
import 'package:flutter/services.dart';
import 'package:medias_picker/medias_picker.dart';
import 'package:vertical_tabs/vertical_tabs.dart';
import 'package:video_player/video_player.dart';

class CreateVotes extends StatefulWidget {
  CreateVotes({Key key}) : super(key: key);

  TestState createState() => new TestState();
}

class TestState extends State<CreateVotes> with TickerProviderStateMixin {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  String dropdownValue = 'Select Vote Type:';
  int _counter = 0;
  List<File> files1 = [];
bool allowNumberEnabled=true;
  ///////page3
  var focusNode = new FocusNode();
  bool isAgeRange = false;
  bool isGender = false;
  bool isLocation = false;
  bool isPrivate = false;
  bool isReportPublic=false;
  final List<String> _list = [
    'gender',
    'location',
    'race',
    'age',
    'occupation',
    'views',
  ];

  List<Tag> _selectableTags = [];

  List _icon = [Icons.home, Icons.language, Icons.headset];
  List _icon1 = [Icons.home, Icons.language, Icons.headset];

  var pollTitle = new TextEditingController();
  var pollDescription = new TextEditingController();
  var pollAllowedNumber = new TextEditingController();
  var pollStartDate = new TextEditingController();
  var pollEndDate = new TextEditingController();

  /////////

  int totalPage;
  int currentPage = 1;
  FocusNode _focusNodeFirstName = new FocusNode();
  final formats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    InputType.time: DateFormat("HH:mm"),
  };
  int pollDisplay = 0;
  List<Widget> pageList = new List<Widget>();
  String votess;

  List _voteby = [
    "star rating",
    "number rating",
    "emoji feedback",
    "like / dislike",
    "yes / no / maybe",
    "text nomination",
    "image / video nomination",
  ];

  //votess
  //["4 star rating", "5 number rating","6 emoji feedback","8 like / dislike","7 yes / no / maybe","1 text nomination", "2 image nomination", "3 video nomination",];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String currentCity;

  //////////////////tag
  TabController _tabController1;
  ScrollController __scrollViewController1;

  final List<String> reportDataNeeded = [
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

  final List<String> restrictionData = [
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
  List<Tag> _selectableTags22 = [];
  String _inputOnPressedTextVote = '';

  List<String> _inputTags = [];

  /////////////
  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    currentCity = _dropDownMenuItems[0].value;
    super.initState();
    totalPage = 4;
    // pageList = <Widget>[page1(), page2(), page3()];

    ////page3

    _list.forEach((item) =>
        _selectableTags.add(Tag(
            title: item,
            active: true,
            icon: (item == '0' || item == '1' || item == '2')
                ? _icon[int.parse(item)]
                : null)));

    //////////

    _tabController1 = TabController(length: 2, vsync: this);
    __scrollViewController1 = ScrollController();

    int cnt = 0;
    reportDataNeeded.forEach((item) {
      _selectableTags22.add(Tag(
          id: cnt,
          title: item,
          active: (_singleItem) ? (cnt == 3 ? true : false) : true,
          icon: (item == '0' || item == '1' || item == '2')
              ? _icon1[int.parse(item)]
              : null));
      cnt++;
    });
  }

  List<String> switchOptions = ["Male", "Female"];
  String selectedSwitchOption = "Male";

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _voteby) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  VoidCallback onFormSubmitted;
  Widget nextButtonStyle;
  Widget previousButtonStyle;
  Widget submitButtonStyle;

  // Changeable in demo
  InputType inputType = InputType.both;
  bool editable = true;
  DateTime date;
  bool _enabled;

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

  @override
  Widget build(BuildContext context) {
    pageList = <Widget>[page1(), page2(), imageNominee(), page3()];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: pageHolder(pageList),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            decoration: new BoxDecoration(
              border: Border.all(color: Colors.transparent),
//              shape: BoxShape.rectangle,
//              image: new DecorationImage(
//                image: new AssetImage("images/createVoteBack1.jpg"),
//                fit: BoxFit.cover,
//              ),
            ),
            height: 45.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                currentPage == 1
                    ? Container()
                    : FlatButton(
                  child: getPreviousButtonWrapper(previousButtonStyle),
                  onPressed: () {
                    setState(() {
                      if (currentCity == "text nomination" &&
                          currentPage == 2) {
                        currentPage = 1;
                      } else if (currentCity ==
                          "image / video nomination" &&
                          currentPage == 3) {
                        currentPage = 1;
                      } else if (currentCity == "text nomination" &&
                          currentPage == 4) {
                        currentPage = 2;
                      } else if (currentCity ==
                          "image / video nomination" &&
                          currentPage == 4) {
                        currentPage = 3;
                      } else if (currentPage == 4) {
                        currentPage = 1;
                      }
                    });
                  },
                ),
                currentPage == 4
                    ? FlatButton(
                    child: getSubmitButtonWrapper(submitButtonStyle),
                    onPressed: () {
                      createVote(pollAllowedNumber.value.text,
                          pollDescription.value.text, "MMM111",
                          dropdownValue, pollTitle.value.text);
                    }
                )
                    : FlatButton(
                  child: getNextButtonWrapper(nextButtonStyle),
                  onPressed: () {
                    if (pollTitle.value.text == "") {
                      validationSnackBar(
                          context, 'Poll Title Can\'t be left empty');
                    }
//                    else if (pollDescription.value.text == "") {
//                      validationSnackBar(
//                          context, 'Poll Description Cant be left empty');
//                    }
                    else if (pollAllowedNumber.value.text == "") {
                      validationSnackBar(context,
                          'Poll Allowed Vote Numbers Can\'t be left empty');
                    } else if (pollAllowedNumber.value.text == "0") {
                      validationSnackBar(
                          context, '0 isn\'t an accepted number');
                    } else {
                      setState(() {
                        if (currentCity == "text nomination" &&
                            currentPage == 2) {
                          currentPage = 4;
                        } else if (currentCity ==
                            "image / video nomination" &&
                            currentPage == 3) {
                          currentPage = 4;
                        } else if (currentCity == "text nomination") {
                          currentPage = 2;
                        } else if (currentCity ==
                            "image / video nomination") {
                          currentPage = 3;
                        } else {
                          currentPage = 4;
                        }
                        //  currentPage = currentPage + 1;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void validationSnackBar(BuildContext context, String validationMessage) {
    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.blueGrey,
      content: Text(validationMessage,style: TextStyle(fontSize: 11),),
      duration: Duration(seconds: 3),
    ));
  }

  Widget getNextButtonWrapper(Widget child) {
    {
      return Row(
        children: <Widget>[
          Text(
            "Next  ",
            style: TextStyle(color: Colors.blueGrey),
          ),
          Image.asset(
            "images/next.png",
            height: 15,
            width: 15,
          )
        ],
      );
    }
  }

  Widget getPreviousButtonWrapper(Widget child) {
    {
      return Row(
        children: <Widget>[
          Image.asset(
            "images/previous.png",
            height: 15,
            width: 15,
          ),
          Text(
            "  Previous",
            style: TextStyle(color: Colors.blueGrey),
          )
        ],
      );
    }
  }

  Widget getSubmitButtonWrapper(Widget child) {
    if (previousButtonStyle != null) {
      return child;
    } else {
      return Row(
        children: <Widget>[
          Text(
            "Submit  ",
            style: TextStyle(color: Colors.blueGrey),
          ),
          Image.asset(
            "images/submit.png",
            height: 15,
            width: 15,
          )
        ],
      );
    }
  }

  String _platformVersion = 'Unknown';
  List<dynamic> docPaths;


  pickImages() async {
    try {
      docPaths = await MediasPicker.pickImages(
          quantity: 1, maxWidth: 1024, maxHeight: 1024, quality: 85);

      String firstPath = docPaths[0] as String;

      List<dynamic> listCompressed = await MediasPicker.compressImages(
          imgPaths: [firstPath], maxWidth: 600, maxHeight: 600, quality: 100);
      print(listCompressed);
    } on PlatformException {}

    setState(() {
      _videoPlayerController1.dispose();
      _videoPlayerController1.pause();
      pollDisplay = 1;
      _platformVersion =
          docPaths.toString().replaceAll("[", "").replaceAll("]", "");
    });

    if (!mounted) return;
  }

  pickVideos() async {
    try {
      docPaths = await MediasPicker.pickVideos(quantity: 1);
    } on PlatformException {}

    setState(() {
      pollDisplay = 2;
      _platformVersion =
      docPaths.toString().replaceAll("[", "").replaceAll("]", "");
      _videoPlayerController1 =
          VideoPlayerController.file(new File(_platformVersion));
    });
    if (!mounted) return;
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Widget page1() {
    return Scaffold(
        appBar: new AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Add Poll Details',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
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
//                              image: new DecorationImage(
//                                image: new AssetImage(
//                                    "images/createVoteBack1.jpg"),
//                                fit: BoxFit.cover,
//                              ),
                            ),
                            transform: new Matrix4.identity()
                              ..scale(1.0),
//                      width: size.width,
//                      height: size.height,
//        color: color ?? Colors.transparent,
                            child: new Padding(
                              padding: const EdgeInsets.all(0.3),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  new ListTile(
                                    leading: const Icon(
                                      Icons.title,
                                      color: Colors.blueGrey,
                                      size: 20,
                                    ),
                                    title: new TextField(
                                      controller: pollTitle,
                                      focusNode: focusNode,
                                      //  autofocus: true,
                                      style: new TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 12.0),
                                      decoration: new InputDecoration(
                                        hintText: "Poll Title *",
                                        hintStyle: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  new ListTile(
                                    leading: const Icon(
                                      Icons.description,
                                      color: Colors.blueGrey,
                                      size: 20,
                                    ),
                                    title: new TextField(
                                      controller: pollDescription,
                                      style: new TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 12.0),
                                      decoration: new InputDecoration(
                                        hintText: "Poll Description",
                                        hintStyle: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.blueGrey,fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),

                                  new ListTile(
                                    leading: const Icon(
                                      Icons.timer,
                                      color: Colors.blueGrey,
                                      size: 20,
                                    ),
                                    title: Column(
                                      children: <Widget>[
                                        DateTimePickerFormField(
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.blueGrey),
                                          inputType: inputType,
                                          format: formats[inputType],
                                          editable: false,
                                          decoration: InputDecoration(
                                              labelStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.blueGrey,
                                                  fontWeight: FontWeight.bold),
                                              labelText:
                                              'Start Poll Date & Time',
                                              hasFloatingPlaceholder: false),
                                          onChanged: (dt) =>
                                              setState(() => date = dt),
                                        ),
                                        DateTimePickerFormField(
                                          inputType: inputType,
                                          format: formats[inputType],
                                          style: TextStyle(
                                              fontSize: 12,

                                              color: Colors.blueGrey),
                                          editable: false,
                                          decoration: InputDecoration(
                                              labelStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.blueGrey,
                                                  fontWeight: FontWeight.bold),
                                              labelText:
                                              'End Poll Date & Time',
                                              hasFloatingPlaceholder: false),
                                          onChanged: (dt) =>
                                              setState(() => date = dt),
                                        ),
                                      ],
                                    ),
                                  ),
                                  new ListTile(
                                    leading: Text("Vote By *",
                                        style: new TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.blueGrey,fontWeight: FontWeight.bold
                                        )),
                                    title: Container(
                                      color: Colors.transparent,
                                      child: new Center(
                                          child: new Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              new DropdownButton(
                                                style: new TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight
                                                        .bold),
                                                value: currentCity,
                                                items: _dropDownMenuItems,
                                                onChanged: changedDropDownItem,
                                              )
                                            ],
                                          )),
                                    ),
                                  ),
                                  new ListTile(
                                    leading: const Icon(
                                      Icons.confirmation_number,
                                      color: Colors.blueGrey,
                                      size: 20,
                                    ),
                                    title: new TextField(
                                      enabled: allowNumberEnabled,
                                      inputFormatters: [
                                        WhitelistingTextInputFormatter
                                            .digitsOnly
                                      ],
                                      controller: pollAllowedNumber,
                                      style: new TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 14.0,fontWeight: FontWeight.bold),
                                      decoration: new InputDecoration(
                                        hintText:
                                        "Allowed Number of Polls Per Voter *",
                                        hintStyle: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.blueGrey),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
//                                  const Divider(
//                                    height: 2.0,
//                                  ),
                                ],
                              ),
                            )))
                  ],
                ),
              ),
            );
          },
        ));
  }


  void _pickImage() async {
    files1.addAll(await AdvImagePicker.pickImagesToFile(context));

    setState(() {});
  }

  Widget imageNominee() {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: Row(
//          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      'Select Vote Type:',
                      'Single Selection',
                      'Multiple Selection',
                      'Vote by Ordering'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[450]),
                        ),
                      );
                    }).toList(),
                  ),
                ))
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 3,
          padding: const EdgeInsets.all(10.0),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: files1
              .map((File f) =>
              Image.file(
                f,
                fit: BoxFit.cover,
              ))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        child: Icon(Icons.add),
        mini: true,
      ),
    );
  }

  Widget page2() {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Add Text Nominees',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Row(
              children: <Widget>[
                Text(' ',
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Center(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      'Select Vote Type:',
                      'Single Selection',
                      'Multiple Selection',
                      'Vote by Ordering'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[450]),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: InputTags(
                placeholder: "Add a Nominee",
                color: Colors.blueGrey,
                autofocus: false,
                tags: _inputTags,
                columns: 3,
                fontSize: 14,
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
              child: Text(_inputOnPressedTextVote),
            ),
          ],
        ));
  }

  Widget page3() {
    _videoPlayerController1 =
        VideoPlayerController.file(new File(_platformVersion));
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 1,
      autoPlay: false,
      looping: true,
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      autoInitialize: true,
    );
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: new AppBar(
          title: TabBar(
            labelColor: Colors.black,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: "Expected Report Data"),
              Tab(text: "Poll Restrictions"),
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: NestedScrollView(
//          controller: __scrollViewController1,
            headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  pinned: false,
                  expandedHeight: 0.0,
                  floating: true,
                  forceElevated: boxIsScrolled,
                )
              ];
            },
            body: TabBarView(
//            controller: _tabController1,
              children: [
                ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(0.1),
                        ),
                        Container(
                          child: new SelectableTags(
                            tags: _selectableTags22,
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
                              fontSize: 12.0,
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
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            FlatButton.icon(
                                              color: Colors.blueGrey[200],
                                              icon: Icon(
                                                Icons.add_photo_alternate,
                                                color: Colors.blueGrey,
                                              ),
                                              //`Icon` to display
                                              label: Text(
                                                'Add a Photo',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 9),
                                              ),
                                              //`Text` to display
                                              onPressed: () {
                                                pickImages();
                                                //Code to execute when Floating Action Button is clicked
                                                //...
                                              },
                                            ),
                                          ],
                                        ),
                                        new Container(
                                          width: 5,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            FlatButton.icon(
                                              color: Colors.blueGrey[200],
                                              icon: Icon(
                                                Icons.video_library,
                                                color: Colors.blueGrey,
                                              ),
                                              //`Icon` to display
                                              label: Text(
                                                'Add a Video',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 9),
                                              ),
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
                            child: pollDisplay == 1
                                ? new Image.file(
                              new File(_platformVersion),
                            )
                                : pollDisplay == 2
                                ? Chewie(
                              controller: _chewieController,
                            )
                                : null),
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
                            tabsWidth: 120,
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
                                        style: TextStyle(fontSize: 12),
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
                                          style: TextStyle(fontSize: 12)),
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
                                          style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 1),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.report),
                                      SizedBox(width: 10),
                                      Text('Private Report',
                                          style: TextStyle(fontSize: 12)),
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
//                                        style: TextStyle(fontSize: 12)),
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
                              tabsContent(
                                Switch(
                                  value: isReportPublic,
                                  onChanged: (value) {
                                    setState(() {
                                      isReportPublic = value;
                                    });
                                  },
                                  activeTrackColor: Colors.blueGrey,
                                  activeColor: Colors.green,
                                ),
                                isReportPublic
                                    ? MaterialSwitch(
                                  padding: const EdgeInsets.all(5.0),
                                  margin: const EdgeInsets.all(5.0),
                                  selectedOption: selectedSwitchOption,
                                  options: switchOptions,
                                  selectedBackgroundColor: isReportPublic
                                      ? Colors.blueGrey
                                      : Colors.grey,
                                  selectedTextColor: isReportPublic
                                      ? Colors.white
                                      : Colors.blueGrey,
                                  onSelect: isReportPublic
                                      ? (String selectedOption) {
                                    setState(() {
                                      selectedSwitchOption =
                                          selectedOption;
                                    });
                                  }
                                      : null,
                                )
                                    : Text(
                                  'Public Report',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      currentCity = selectedCity;
      if (selectedCity == "star rating") {
        allowNumberEnabled=false;
        pollAllowedNumber.text='1';
      } else if (selectedCity == "number rating") {
        allowNumberEnabled=false;
        pollAllowedNumber.text='1';

      } else if (selectedCity == "emoji feedback") {
        allowNumberEnabled=false;
        pollAllowedNumber.text='1';

      } else if (selectedCity == "like / dislike") {
        allowNumberEnabled=false;
        pollAllowedNumber.text='1';

      } else if (selectedCity == "yes / no / maybe") {
        allowNumberEnabled=false;
        pollAllowedNumber.text='1';

      } else if (selectedCity == "text nomination") {
        allowNumberEnabled=true;

      } else if (selectedCity == "image / video nomination") {
        allowNumberEnabled=true;

      }
      //  FocusScope.of(context).requestFocus(focusNode);

//      pageList.removeAt(1);
//
//      if (currentCity == "star rating") {
//        pageList.insert(1, ImagePickers());
//      }
//// else if (currentCity == "number rating") {
////        pageList.insert(1, Text("number rating"));
////      } else if (currentCity == "emoji feedback") {
////        pageList.insert(1, Text("emoji feedback"));
////      } else if (currentCity == "like / dislike") {
////        pageList.insert(1, Text("like / dislike"));
////      } else if (currentCity == "yes / no / maybe") {
////        pageList.insert(1, Text("yes / no / maybe"));
////      } else
//
//      else if (currentCity == "text nomination") {
//        pageList.insert(1, page2());
//      } else if (currentCity == "image / video nomination") {
//        pageList.insert(1, MultiPicker());
//      }
////    else if (currentCity == "video nomination") {
////        pageList.insert(1, Text("video nomination"));
////      }
    });
  }

  Widget pageHolder(List<Widget> pageList) {
    for (int i = 1; i <= totalPage; i++) {
      if (currentPage == i) {
        return pageList[i - 1];
      }
    }
    return Container();
  }

  createVote(String voteNumberAllowed, String description, String memberID,
      String voteType, String title) {
    int voteBy;
    if (currentCity == "star rating") {
      voteBy = 4;
    } else if (currentCity == "number rating") {
      voteBy = 5;
    } else if (currentCity == "emoji feedback") {
      voteBy = 6;
    } else if (currentCity == "like / dislike") {
      voteBy = 8;
    } else if (currentCity == "yes / no / maybe") {
      voteBy = 7;
    } else if (currentCity == "text nomination") {
      voteBy = 1;
    } else if (currentCity == "image / video nomination") {
      voteBy = 1;
    }
    else{
      voteBy = 4;
    }
//    else if (currentCity == "video nomination") {
//        pageList.insert(1, Text("video nomination"));
//      }

    var userData = Firestore.instance.collection('users').where('member_id', isEqualTo: memberID);
    String profilePic;
    String owner;
    int loginProvider;
    userData.getDocuments().then((data) async {
      if (data.documents.length > 0){
        setState(() {
          profilePic = data.documents[0].data['profile_pic'];
//          profilePic = data.documents[0].data['profile_pic'];

        });
      }


      FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
        owner=user.displayName;
        profilePic=user.photoUrl;
        if(user.photoUrl.contains('facebook')){
          loginProvider=1;
        }
        else if(user.photoUrl.contains('google')) {
          loginProvider=2;
        }
        else if(user.photoUrl.contains('twitter')){
          loginProvider=3;
        }
        });


      var reportDataToExpect= new StringBuffer();
      for(Tag reportData in _selectableTags22){
          if(!reportData.active){
            reportDataToExpect.write(reportData.id.toString()+',');
          }
      }

      if(_platformVersion=='Unknown'&& (null==description||description=="")){
          validationSnackBar(context, "Poll Description & Poll Main Display cn\'t both be left empty.");
          return;
      }

    CollectionReference collectionReference = Firestore.instance.collection(
        'votes');
    DocumentReference docReferance = collectionReference.document();
    docReferance.setData({
      'allowedVoteNumber': voteNumberAllowed,
      'description': description,
      'enabled': false,
      'memberID': memberID,
      'postType': pollDisplay,
      'voteBy': voteBy,
      'voteType': voteType,
      'reportDataToExpect':removeLastChar(reportDataToExpect.toString()),
      'creationDateTime':new DateTime.now(),
//      'postPath':postPath,
      'title': title,


    });

      String downloadUrl=null;
    try {
      final StorageReference ref = new FirebaseStorage().ref().child(
          memberID + "/votes/" + docReferance.documentID);
      final StorageUploadTask uploadTask = ref.putFile(
          new File(_platformVersion));
      if(uploadTask.isComplete) {
        if(uploadTask.isSuccessful) {
          StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
          downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
          validationSnackBar(context,'Upload Successful');
        } else if(uploadTask.isCanceled) {
          validationSnackBar(context,'Upload Cancelled');
        } else {
          print('${uploadTask.lastSnapshot.error}');
        }
      } else if(uploadTask.isInProgress){
        validationSnackBar(context,'Upload in Progress');
      } else if(uploadTask.isPaused) {
        print('Upload Paused');
      }

    }
    catch(e){

    }

      Firestore.instance
          .collection('votes')
          .document(docReferance.documentID)
          .updateData({"postPath":downloadUrl,
        'owner': owner,
        'profile_pic':profilePic,
        'loginProvider':loginProvider,
        'enabled': true,});


    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => Home()),
    );
  });}

//
//  uploadImageToFileStorageonError: (String memberID, String voteID) async {
//    final StorageReference ref = new FirebaseStorage().ref().child(memberID+"/votes/" + voteID );
//    final StorageUploadTask uploadTask = ref.putFile(new File(_platformVersion));
//    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
//    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
//    String dsf="fds";
//    Firestore.instance
//        .collection('votes')
//        .document(voteID)
//    .updateData({"postPath":downloadUrl,
//      'enabled': true,})
//        .catchError((e) {
//      print(e);
//    });
////      return uploadTask;
//
//
//
//
//  }

  String removeLastChar(String str) {
    return str.substring(0, str.length - 1);
  }

}
