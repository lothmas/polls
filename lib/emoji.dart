import 'package:flutter/material.dart';
import 'package:stats/emojiConfig.dart';
//import 'package:emoji_feedback/emoji_feedback.dart';


class Emoji extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
//        padding: EdgeInsets.only(top: 48.0, left: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 3,
            ),
            Row(
              //  crossAxisAlignment: CrossAxisAlignment.b,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('FeedBack:',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                Text('polls: 5448',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
              ],),
            Container(
              height: 3,
            ),
            EmojiFeedback(
              onChange: (index) {
                print(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}