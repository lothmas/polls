import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stats/NomineeMasterObject.dart';
import 'package:stats/dropcity/dragbox.dart';

class DropCityApp extends StatelessWidget {
  List<NomineesEntityList> items;
  int voteBy;
  String backgroundImage;

  DropCityApp(this.items, this.voteBy,this.backgroundImage);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _getTheme(context),
        home: new Scaffold(
            appBar: new AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'images/long_press.png',
                    fit: BoxFit.contain,
                    height: 50,
                  ),
                  Container(
                      padding: const EdgeInsets.all(8.0), child: Text('Long-Press Favourite, Drag then Drop  ',style: TextStyle(fontSize: 10,color: Colors.black,fontWeight: FontWeight.bold),))
                ],

              ),backgroundColor: Colors.white,
            ),

            body: new Stack(
          children: <Widget>[
//            new Container(
//              decoration: new BoxDecoration(
//                image: new DecorationImage(
//                  image: new AssetImage(backgroundImage),
//                  fit: BoxFit.cover,
//                ),
//              ),
//            ),
            // new Icon(Icons.monetization_on, size: 36.0, color: const Color.fromRGBO(218, 165, 32, 1.0)),
//            new Positioned(
//
//                bottom: 0.0,
//                right: 0,
//                child: Transform.scale(
//                    scale: 0.4,
//                    child: new FloatingActionButton(
//                      child: Image(
//                        image: new AssetImage("images/background1.jpg"),
////                    width: 10,
////                    height: 18,
//                        color: null,
//                        fit: BoxFit.cover,
//                        alignment: Alignment.center,
//                      ),
//                      onPressed: () {
//                        backgroundImage="images/background1.jpg";
//                        new DropCityApp(this.items, this.voteBy,backgroundImage);
//                      },
//                    ))),
//            new Positioned(
//                bottom: 0.0,
//                right: 0,
//                child: new FloatingActionButton(
//
//                  onPressed: () {},
//                )),

            new Center(
              child: new GameView(items, voteBy),
            )
          ],
        )));
  }

  ThemeData _getTheme(BuildContext context) => Theme.of(context).copyWith(
      textTheme: new TextTheme(
          body1: new TextStyle(fontSize: 16.0, color: Colors.black)));
}
