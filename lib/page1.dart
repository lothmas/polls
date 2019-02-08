import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stats/date_time.dart';
import 'package:stats/on_off.dart';
import 'package:stats/vote_by_dropdown.dart';
import 'package:toggle_button/toggle_button.dart';

class Page1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CurrencyState();
  }
}

class _CurrencyState extends State<Page1> with TickerProviderStateMixin {
  final formats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    InputType.time: DateFormat("HH:mm"),
  };

  // Changeable in demo
  InputType inputType = InputType.both;
  bool editable = true;
  DateTime date;
  bool _enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          title: SettingsWidget(),
        ),
        new ListTile(
          leading: const Icon(
            Icons.lock,
            color: Colors.grey[350],
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
    );
  }

  void updateInputType({bool date, bool time}) {
    date = date ?? inputType != InputType.time;
    time = time ?? inputType != InputType.date;
    setState(() => inputType =
        date ? time ? InputType.both : InputType.date : InputType.time);
  }

  double _currencyCalculate(String amount, double multiplier) {
    double _amount = amount.isNotEmpty ? double.parse(amount) : 0.0;

    if (_amount.toString().isNotEmpty && _amount > 0) {
      return _amount * multiplier;
    } else {
      return -1.0;
    }
  }
}
