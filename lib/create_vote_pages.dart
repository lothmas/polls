import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stats/MultiplePages.dart';
import 'package:stats/age_range.dart';
import 'package:stats/page1.dart';
import 'package:stats/tag.dart';
import 'package:stats/tag1.dart';
import 'package:stats/text_focus_helper.dart';
import 'package:stats/vote_by_dropdown.dart';
import 'package:toggle_button/toggle_button.dart';

class CreateVotes extends StatefulWidget {
  _TestState createState() => _TestState();
}

class _TestState extends State<CreateVotes> {
  FocusNode _focusNodeFirstName = new FocusNode();
  final formats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    InputType.time: DateFormat("HH:mm"),
  };

  List<Widget> pageList;
  String votess;

  List _voteby =
  ["star rating", "number rating","emoji feedback","like / dislike","yes / no / maybe","text nomination", "image nomination", "video nomination",];

  //votess
  //["4 star rating", "5 number rating","6 emoji feedback","8 like / dislike","7 yes / no / maybe","1 text nomination", "2 image nomination", "3 video nomination",];


  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String currentCity;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    currentCity = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _voteby) {
      items.add(new DropdownMenuItem(
          value: city,
          child: new Text(city)
      ));
    }
    return items;
  }
  // Changeable in demo
  InputType inputType = InputType.both;
  bool editable = true;
  DateTime date;
  bool _enabled;
  @override
  Widget build(BuildContext context) {
    pageList=<Widget>[page1(), page2(), VoteNeededData()];
    return MultiPageForm(
      totalPage: 3,
      pageList:pageList ,
      onFormSubmitted: () {
        print("Form is submitted");
      },
    );
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
                          image: new AssetImage("images/background.jpg"),
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
                            leading: const Icon(
                              Icons.title,
                              color: Colors.grey,
                              size: 20,
                            ),
                            title: new TextField(
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
                              color: Colors.grey,
                              size: 20,
                            ),
                            title: new TextField(
                              style: new TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold),
                              decoration: new InputDecoration(
                                hintText: "Poll Description *",
                                hintStyle: TextStyle(fontSize: 11.0, color: Colors.white70),
                              ),
                            ),
                          ),

                          new ListTile(
                            leading: const Icon(
                              Icons.confirmation_number,
                              color: Colors.grey,
                              size: 20,
                            ),
                            title: new TextField(
                              style: new TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold),
                              decoration: new InputDecoration(
                                hintText: "Allowed Number of Polls Per Voter *",
                                hintStyle: TextStyle(fontSize: 11.0, color: Colors.white70),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),


                          new ListTile(
                            leading: const Icon(
                              Icons.timer,
                              color: Colors.grey,
                              size: 20,
                            ),
                            title: Column(
                              children: <Widget>[
                                DateTimePickerFormField(
                                  inputType: inputType,
                                  format: formats[inputType],
                                  editable: editable,
                                  decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                          fontSize: 11,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold),
                                      labelText: 'Start Poll Date & Time *',
                                      hasFloatingPlaceholder: false),
                                  onChanged: (dt) => setState(() => date = dt),
                                ),
                                DateTimePickerFormField(
                                  inputType: inputType,
                                  format: formats[inputType],
                                  editable: editable,
                                  decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                          fontSize: 11,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold),
                                      labelText: 'End Poll Date & Time *',
                                      hasFloatingPlaceholder: false),
                                  onChanged: (dt) => setState(() => date = dt),
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
                              color: Colors.grey,
                              child: new Center(
                                  child: new Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
//              new Container(
//                padding: new EdgeInsets.all(0.0),
//              ),
                                      new DropdownButton(
                                        style: new TextStyle( color: Colors.blueGrey, fontSize: 12.0,fontWeight: FontWeight.bold),
                                        value: currentCity,
                                        items: _dropDownMenuItems,
                                        onChanged: changedDropDownItem,
                                      )
                                    ],
                                  )
                              ),
                            ),
                          ),
                          new ListTile(
                            leading: const Icon(
                              Icons.lock,
                              color: Colors.grey,
                              size: 20,
                            ),
                            title: new Container(
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text("Poll is Private",
                                      style: TextStyle(
                                          fontSize: 11.0,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold)),
                                  Container(
                                    width: 5,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 11.0, bottom: 11.0),
                                    child: ToggleButton(
                                      borderRadius: 40.0,
                                      size: 9.0,
                                      onChange: (sta) {
                                        print(sta);
                                      },
                                      axis: ToggleButtonAlignment.horizontal,
                                    ),
                                  ),
                                ],
                              ),
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
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget page2() {

//      if()
    String voteBy=SettingsWidgetState().votess;

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
    return VoteNeededData();

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
                VoteNeededData(),
//                 AgeRange(),
              ],
            ),
          ),
        );
      },
    );
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      currentCity = selectedCity;
      votess=selectedCity;
      List<Widget> dd=MultiPageForm().pageList;
      String ssdsd="as";
    });
  }
}
