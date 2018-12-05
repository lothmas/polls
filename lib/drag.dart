import 'package:flutter/material.dart';
import 'package:stats/NomineeMasterObject.dart';
import 'package:stats/dropcity/dragbox.dart';

class DropCityApp extends StatelessWidget {
  List<NomineesEntityList> items;
  DropCityApp(this.items);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: _getTheme(context),
        home: new Scaffold(
          body: new GameView(items),
        ));
  }

  ThemeData _getTheme(BuildContext context) => Theme.of(context).copyWith(
      textTheme: new TextTheme(
          body1: new TextStyle(fontSize: 16.0, color: Colors.grey.shade700)));
}
