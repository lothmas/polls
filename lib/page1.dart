import 'package:flutter/material.dart';
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

  bool _enabled;
  @override
  Widget build(BuildContext context) {
     return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new ListTile(
            leading: const Icon(Icons.title,color: Colors.blueGrey,size: 20,),
            title: new TextField(style: new TextStyle( color: Colors.black, fontSize: 12.0,fontWeight: FontWeight.bold),
            decoration: new InputDecoration(
            hintText: "Poll Title *",
              hintStyle: TextStyle(fontSize: 12.0, color: Colors.white70,fontWeight: FontWeight.bold),
            ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.description,color: Colors.blueGrey,size: 20,),
            title: new TextField(style: new TextStyle( color: Colors.black, fontSize: 12.0,fontWeight: FontWeight.bold),
              decoration: new InputDecoration(
                hintText: "Poll Description *",
                hintStyle: TextStyle(fontSize: 12.0, color: Colors.white70),
              ),
            ),
          ),

          new ListTile(
            leading: const Icon(Icons.confirmation_number,color: Colors.blueGrey,size: 20,),
            title: new TextField( style: new TextStyle( color: Colors.black, fontSize: 12.0,fontWeight: FontWeight.bold),
              decoration: new InputDecoration(
                hintText: "Allowed Number of Polls Per Voter *",
                hintStyle: TextStyle(fontSize: 12.0, color: Colors.white70),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.lock,color: Colors.blueGrey,size:20 ,),
            title: new Container(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Poll is Private",style: TextStyle(  fontSize: 12.0,color: Colors.white70,fontWeight: FontWeight.bold)),
                  Container(width: 5,)
                  ,
                  Container(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
          new ListTile(
            leading: const Icon(Icons.timer,color: Colors.blueGrey,size:20 ,),
            title: new Container(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Poll Duration",style: TextStyle(  fontSize: 12.0,color: Colors.white70,fontWeight: FontWeight.bold)),
                  Container(width: 5,)
                  ,
//                  Container(
//                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
//                    child: new MyHomePage(),
//                  ),
                ],
              ),
            ),
          ),

          new ListTile(
            leading: Text("vote by*:",style: new TextStyle(  fontSize: 14.0,color: Colors.white70,fontWeight: FontWeight.bold,)),
            title: SettingsWidget(),
          ),

          const Divider(
            height: 1.0,
          ),

//
//        new ListTile(
//     //     leading: const Icon(Icons.cloud_upload),
//          title: const Text('Upload Poll Image / Video',style:  TextStyle( color: Colors.white70, fontSize: 8.0,fontWeight: FontWeight.bold),) ,
//
//        ),
          Container(
            color: Colors.transparent,
            height: 5,
          ),
          Text('Upload Poll Image / Video',style:  TextStyle( color: Colors.black, fontSize: 11.0,fontWeight: FontWeight.bold),),
          Container(
            width: 70.0,
            height: 90.0,
            child: FadeInImage.assetNetwork(
              placeholder: 'images/picker.png',
              image: "",
              fit: BoxFit.fill,

            ),
          ),




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

  double _currencyCalculate(String amount, double multiplier) {
    double _amount = amount.isNotEmpty ? double.parse(amount) : 0.0;

    if (_amount.toString().isNotEmpty && _amount > 0) {
      return _amount * multiplier;
    } else {
      return -1.0;
    }
  }
}
