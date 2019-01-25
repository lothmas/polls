import 'package:flutter/material.dart';
import 'package:stats/vote_by_dropdown.dart';

class Page1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CurrencyState();
  }
}

class _CurrencyState extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
//          Row(
//          crossAxisAlignment: CrossAxisAlignment.end,
//          children: [
////            Container(
////              color: Colors.transparent,
////              width: 10.0,
////            ),
//            Container(
//              //   padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
////          decoration: new BoxDecoration(color: Colors.white30, boxShadow: [
////            new BoxShadow(
////              color: Colors.white,
////              blurRadius: 20.0,
////            ),
////          ]),
//              color: Colors.transparent,
//              child: ClipOval(
//                child: FadeInImage.assetNetwork(
//                  placeholder: 'images/loader.gif',
//                  image: "https://www.goldderby.com/wp-content/uploads/2016/12/Voice-Logo.jpg",
//                  fit: BoxFit.fill,
//                  width: 50.0,
//                  height: 50.0,
//                ),
//              ),
//            ),
//            Container(
//              color: Colors.transparent,
//              width: 10.0,
//            ),
//            Column(
//              children: [
//                Container(
//                  child: new Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: [
//                      Container(
//                        color: Colors.transparent,
//                        child: Text(
//                          'owner:  ',
//                          textAlign: TextAlign.left,
//                        ),
//                      ),
//                      Container(
//                        color: Colors.transparent,
//                        child: Text(
//                          "fifa.world.cup",
//                          textAlign: TextAlign.left,
//                          style: TextStyle(color: Colors.teal),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                Container(
//                  color: Colors.transparent,
//                  height: 7,
//                ),
//
//
//                Container(
//                  child: new Column(
////                    mainAxisAlignment: MainAxisAlignment.center,
//                      children: [
//                        new Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceAround,
//                          children: [
//                            Container(
//                              color: Colors.transparent,
//                              width: 20,
//                            ),
//                            Container(
//                              color: Colors.transparent,
//                              width: 58,
//                            ),
//                            Container(
//                              color: Colors.transparent,
//                              width: 58,
//                            ),
//                          ],
//                        ),
//                      ]),
//                ),
//              ],
//            ),
//            Container(
//              color: Colors.transparent,
//              width: 30,
//            ),
//            new Align(
//                child: Container(
//                    color: Colors.black12,
//                    child: Badge.right(
////                      (trending.getVotesCasted()+" | "+trending.getAllowedVoteNumber()) );
//                        value: '0' + ' | ' + '0',
//                        color: Colors.white70,
//                        // value to show inside the badge
//                        child: new Text("") // text to append (required)
//                    ))),
//          ],
//        ),


          new ListTile(
            leading: const Icon(Icons.title),
            title: new TextField(style: new TextStyle( color: Colors.white70, fontSize: 12.0,),
              decoration: new InputDecoration(
                hintText: "Poll Title",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.description),
            title: new TextField(style: new TextStyle( color: Colors.white70, fontSize: 12.0,),
              decoration: new InputDecoration(
                hintText: "Poll Description",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.confirmation_number),
            title: new TextField( style: new TextStyle( color: Colors.white70, fontSize: 12.0,),
              decoration: new InputDecoration(
                hintText: "Allowed Number of Polls Per Voter",
              ),
            ),
          ),
          new ListTile(
            leading: Text("vote by:",style: new TextStyle(  fontSize: 14.0,fontWeight: FontWeight.bold)),
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
            height: 10,
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
      )
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
