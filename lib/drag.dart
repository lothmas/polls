import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stats/NomineeMasterObject.dart';
import 'package:stats/dropcity/dragbox.dart';

class DropCityApp extends StatelessWidget {
  List<NomineesEntityList> items;
  int voteBy;
  String backgroundImage;

  DropCityApp(this.items, this.voteBy, this.backgroundImage);

  @override
  Widget build(BuildContext context) {
    var main = new MaterialApp(
        home: new Scaffold(
      body: new GameView(items, voteBy),
    ));
    return banner(main);
  }

  Stack banner(MaterialApp main) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        main,
        Banner(
          message: "Single-Select",
          location: BannerLocation.topEnd,
        ),
      ],
    );
  }

  ThemeData _getTheme(BuildContext context) => Theme.of(context).copyWith(
      textTheme: new TextTheme(
          body1: new TextStyle(fontSize: 16.0, color: Colors.black)));
}
