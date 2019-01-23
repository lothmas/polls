import 'package:flutter/material.dart';


class SettingsWidget extends StatefulWidget {
  SettingsWidget({Key key}) : super(key: key);

  @override
  SettingsWidgetState createState() => new SettingsWidgetState();
}

class SettingsWidgetState extends State<SettingsWidget> {

  List _voteby =
  ["star rating", "number rating","like / dislike","yes / no","text selection", "image selection", "video selection",];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
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

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.transparent,
      child: new Center(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//              new Container(
//                padding: new EdgeInsets.all(0.0),
//              ),
              new DropdownButton(
                style: new TextStyle( color: Colors.blueGrey, fontSize: 14.0,),
                value: _currentCity,
                items: _dropDownMenuItems,
                onChanged: changedDropDownItem,
              )
            ],
          )
      ),
    );
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentCity = selectedCity;
    });
  }

}