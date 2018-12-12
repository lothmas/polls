import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stats/NomineeMasterObject.dart';
import 'package:stats/dropcity/dragbox.dart';

class DropCityApp extends StatelessWidget {
  List<NomineesEntityList> items;
  int voteBy;
  DropCityApp(this.items, this.voteBy);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: _getTheme(context),
        home: new Scaffold(

            body: new Stack(
              children: <Widget>[
                new Container(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(image: new AssetImage("images/background.jpg"), fit: BoxFit.cover,),
                  ),
                ),
                new Center(
                  child: new GameView(items,voteBy),
                )
              ],
            )



        ));
  }

  ThemeData _getTheme(BuildContext context) => Theme.of(context).copyWith(
      textTheme: new TextTheme(
          body1: new TextStyle(fontSize: 16.0, color: Colors.grey.shade700)));
}
