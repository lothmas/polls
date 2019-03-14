import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:intl/intl.dart';
import 'package:stats/MultiplePages.dart';
import 'package:stats/age_range.dart';
import 'package:stats/image_picker.dart';
import 'package:stats/multipleorder/multipicker.dart';
import 'package:stats/page1.dart';
import 'package:stats/tag.dart';
import 'package:stats/tag1.dart';
import 'package:stats/text_focus_helper.dart';
import 'package:stats/vote_by_dropdown.dart';
import 'package:toggle_button/toggle_button.dart';
import 'package:flutter/services.dart';
import 'package:medias_picker/medias_picker.dart';

class CreateVotes extends StatefulWidget {
  CreateVotes({Key key}) : super(key: key);

  TestState createState() => new TestState();
}

class TestState extends State<CreateVotes> with SingleTickerProviderStateMixin {
  ///////page3
  var focusNode = new FocusNode();
  TabController _tabController;
  ScrollController _scrollViewController;

  final List<String> _list = [
    'gender',
    'location',
    'race',
    'age',
    'occupation',
    'views',
  ];

  bool _symmetry = true;
  int _column = 4;
  double _fontSize = 12;

  String _selectableOnPressed = '';
  String _inputOnPressed = '';

  List<Tag> _selectableTags = [];
  List<String> _inputTags = [];

  List _icon = [Icons.home, Icons.language, Icons.headset];

  /////////

  int totalPage;
  int currentPage = 1;
  FocusNode _focusNodeFirstName = new FocusNode();
  final formats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    InputType.time: DateFormat("HH:mm"),
  };

  List<Widget> pageList;
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

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    currentCity = _dropDownMenuItems[0].value;
    super.initState();
    totalPage = 3;
    pageList = <Widget>[page1(), page2(), page3()];

    ////page3

    _tabController = TabController(length: 2, vsync: this);
    _scrollViewController = ScrollController();

    _list.forEach((item) => _selectableTags.add(Tag(
        title: item,
        active: true,
        icon: (item == '0' || item == '1' || item == '2')
            ? _icon[int.parse(item)]
            : null)));

    //////////
  }

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

  @override
  Widget build(BuildContext context) {
    List<Widget> pageList = <Widget>[page1(), page2(), page3()];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: pageHolder(),
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
                            currentPage = currentPage - 1;
                          });
                        },
                      ),
                currentPage == totalPage
                    ? FlatButton(
                        child: getSubmitButtonWrapper(submitButtonStyle),
                        onPressed: onFormSubmitted,
                      )
                    : FlatButton(
                        child: getNextButtonWrapper(nextButtonStyle),
                        onPressed: () {
                          setState(() {
                            BuildContext voteBy = SettingsWidgetState().context;
                            currentPage = currentPage + 1;
                          });
                        },
                      ),
              ],
            ),
          ),
        )
      ],
    );
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
      _platformVersion =
          docPaths.toString().replaceAll("[", "").replaceAll("]", "");
      String sf = "fds";
    });

    if (!mounted) return;
  }

  pickVideos() async {
    try {
      docPaths = await MediasPicker.pickVideos(quantity: 1);
    } on PlatformException {}

    setState(() {
      _platformVersion =
          docPaths.toString().replaceAll("[", "").replaceAll("]", "");
      FocusScope.of(context).requestFocus(focusNode);
      String sf = "fds";
    });

    if (!mounted) return;
  }

  Widget page1() {
    return LayoutBuilder(
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
                          image: new DecorationImage(
                            image: new AssetImage("images/createVoteBack1.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        transform: new Matrix4.identity()..scale(1.0),
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
                                  focusNode: focusNode,
                                  //  autofocus: true,
                                  style: new TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.bold),
                                  decoration: new InputDecoration(
                                    hintText: "Poll Title *",
                                    hintStyle: TextStyle(
                                        fontSize: 11.0,
                                        color: Colors.white70,
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
                                  style: new TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.bold),
                                  decoration: new InputDecoration(
                                    hintText: "Poll Description *",
                                    hintStyle: TextStyle(
                                        fontSize: 11.0, color: Colors.white70),
                                  ),
                                ),
                              ),

                              new ListTile(
                                leading: const Icon(
                                  Icons.confirmation_number,
                                  color: Colors.blueGrey,
                                  size: 20,
                                ),
                                title: new TextField(
                                  style: new TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.bold),
                                  decoration: new InputDecoration(
                                    hintText:
                                        "Allowed Number of Polls Per Voter *",
                                    hintStyle: TextStyle(
                                        fontSize: 11.0, color: Colors.white70),
                                  ),
                                  keyboardType: TextInputType.number,
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
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey),
                                      inputType: inputType,
                                      format: formats[inputType],
                                      editable: false,
                                      decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              fontSize: 11,
                                              color: Colors.white70,
                                              fontWeight: FontWeight.bold),
                                          labelText: 'Start Poll Date & Time *',
                                          hasFloatingPlaceholder: false),
                                      onChanged: (dt) =>
                                          setState(() => date = dt),
                                    ),
                                    DateTimePickerFormField(
                                      inputType: inputType,
                                      format: formats[inputType],
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey),
                                      editable: false,
                                      decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              fontSize: 11,
                                              color: Colors.white70,
                                              fontWeight: FontWeight.bold),
                                          labelText: 'End Poll Date & Time *',
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
                                      fontSize: 11.0,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                    )),
                                title: Container(
                                  color: Colors.transparent,
                                  child: new Center(
                                      child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
//              new Container(
//                padding: new EdgeInsets.all(0.0),
//              ),
                                      new DropdownButton(
                                        style: new TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold),
                                        value: currentCity,
                                        items: _dropDownMenuItems,
                                        onChanged: changedDropDownItem,
                                      )
                                    ],
                                  )),
                                ),
                              ),
                              const Divider(
                                height: 2.0,
                              ),

//
//        new ListTile(
//     //     leading: const Icon(Icons.cloud_upload),
//          title: const Text('Upload Poll Image / Video',style:  TextStyle( color: Colors.white70, fontSize: 8.0,fontWeight: FontWeight.bold),) ,
//
//        ),
//        Container(
//          color: Colors.transparent,
//          height: 5,
//        ),
//        Text(
//          'Upload Poll Image / Video',
//          style: TextStyle(
//              color: Colors.grey, fontSize: 11.0, fontWeight: FontWeight.bold),
//        ),
//        Container(
//          width: 70.0,
//          height: 90.0,
//          child: FadeInImage.assetNetwork(
//            placeholder: 'images/picker.png',
//            image: "",
//            fit: BoxFit.fill,
//          ),
//        ),

//          new ListTile(
//            leading: const Icon(Icons.today),
//            title: const Text('Birthday'),
//            subtitle: const Text('February 20, 1980'),
//          ),
//          new ListTile(
//            leading: const Icon(Icons.group),
//            title: const Text('Contact group'),
//            subtitle: const Text('Not specified'),
//          )
//
                            ],
                          ),
                        )))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget page2() {
//      if()
    String voteBy = SettingsWidgetState().votess;

    return MyApp();
    return LayoutBuilder(
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
                //
//        new ListTile(
//     //     leading: const Icon(Icons.cloud_upload),
//          title: const Text('Upload Poll Image / Video',style:  TextStyle( color: Colors.white70, fontSize: 8.0,fontWeight: FontWeight.bold),) ,
//
//        ),
//        Container(
//          color: Colors.transparent,
//          height: 5,
//        ),
//        Text(
//          'Upload Poll Image / Video',
//          style: TextStyle(
//              color: Colors.grey, fontSize: 11.0, fontWeight: FontWeight.bold),
//        ),
//        Container(
//          width: 70.0,
//          height: 90.0,
//          child: FadeInImage.assetNetwork(
//            placeholder: 'images/picker.png',
//            image: "",
//            fit: BoxFit.fill,
//          ),
//        ),
                MyApp(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget page3() {
    return Tags();

//    return LayoutBuilder(
//      builder: (BuildContext context, BoxConstraints viewportConstraints) {
//        return SingleChildScrollView(
//          child: ConstrainedBox(
//            constraints: BoxConstraints(
//              minHeight: viewportConstraints.maxHeight,
//            ),
//            child:
//          ),
//        );
//      },
//    );
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      currentCity = selectedCity;
      FocusScope.of(context).requestFocus(focusNode);

      pageList.removeAt(1);

      if (currentCity == "star rating") {
        pageList.insert(1, ImagePickers());
      }
// else if (currentCity == "number rating") {
//        pageList.insert(1, Text("number rating"));
//      } else if (currentCity == "emoji feedback") {
//        pageList.insert(1, Text("emoji feedback"));
//      } else if (currentCity == "like / dislike") {
//        pageList.insert(1, Text("like / dislike"));
//      } else if (currentCity == "yes / no / maybe") {
//        pageList.insert(1, Text("yes / no / maybe"));
//      } else

      else if (currentCity == "text nomination") {
        pageList.insert(1, page2());
      } else if (currentCity == "image / video nomination") {
        pageList.insert(1, MultiPicker());
      }
//    else if (currentCity == "video nomination") {
//        pageList.insert(1, Text("video nomination"));
//      }
    });
  }

  Widget pageHolder() {
    for (int i = 1; i <= totalPage; i++) {
      if (currentPage == i) {
        return pageList[i - 1];
      }
    }
    return Container();
  }
}
