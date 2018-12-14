import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stats/NomineeMasterObject.dart';
import 'package:stats/Polling.dart';
import 'package:stats/dropcity/dragbox.dart';
String voteID;
int voteBy;
int voteType;
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new HomeScreen());
  }

  MyApp({String voteID, voteBy, voteType}){
   voteID=voteID;
   voteBy=voteBy;
   voteType=voteType;
  }


}

class HomeScreen extends StatelessWidget {
//  String voteID;
//  int voteBy;
//  int voteType;
//  HomeScreen({String voteID, voteBy, voteType}){
//    this.voteID=voteID;
//    this.voteBy=voteBy;
//    this.voteType=voteType;
//  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white70,
          child: Image.asset(
            "images/cast.png",
            width: 22.0,
            height: 22.0,
          ),
          heroTag: "kjfuyv",
          mini: true,
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new Polling(
                      voteID: voteID,
                      voteBy: voteBy,
                      voteType: voteType)

              ),
            );
          }),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.5,
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        //notchMargin: 4.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Image.asset(
                "images/trending.png",
                width: 22.0,
                height: 22.0,
              ),
              onPressed: () {
//                Navigator.push(
//                  context,
//                  new MaterialPageRoute(
//                      builder: (context) => new Polling(
//                          voteID: document.documentID,
//                          voteBy: document['voteBy'],
//                          voteType: document['voteType'])),
//                );
              },
            ),
            Column(
              children: <Widget>[
                Container(
                  height: 30.0,
                ),
                Text(
                  '12 hrs ago',
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            IconButton(
              icon: Image.asset(
                "images/share.png",
                width: 22.0,
                height: 22.0,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
