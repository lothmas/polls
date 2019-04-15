import 'package:flutter/material.dart';
import 'package:stats/emojiConfig.dart';
//import 'package:emoji_feedback/emoji_feedback.dart';


class Emoji extends StatelessWidget {
  int castedVoteNumber;
  Emoji(this.castedVoteNumber);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(castedVoteNumber),
    );
  }
}

class HomePage extends StatelessWidget {
  int castedVoteNumber;
  HomePage(this.castedVoteNumber);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,

      body: Container(
//        padding: EdgeInsets.only(top: 48.0, left: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 2,
            ),

            EmojiFeedback(
              currentIndex: castedVoteNumber,
              onChange: (index) {
                print(index);
              },
            ),
            Container(
              height: 5,
            ),
//            Row(
//              //  crossAxisAlignment: CrossAxisAlignment.b,
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Text('FeedBack:',
//                    style: TextStyle(
//                        fontSize: 12,
//                        fontWeight: FontWeight.bold,
//                        color: Colors.grey)),
//                Text('polls: 5448',
//                    style: TextStyle(
//                        fontSize: 12,
//                        fontWeight: FontWeight.bold,
//                        color: Colors.grey)),
//              ],),

          ],
        ),
      ),
    );
  }
}