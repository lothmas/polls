import 'package:flutter/material.dart';
import 'package:stats/emojiConfig.dart';
//import 'package:emoji_feedback/emoji_feedback.dart';


class Emoji extends StatelessWidget {
  final String voteID, memberID;
  double castedVoteNumber;
  Emoji(this.castedVoteNumber,this.voteID,this.memberID);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(castedVoteNumber,voteID,memberID),
    );
  }
}

class HomePage extends StatelessWidget {
  String voteID, memberID;

  double castedVoteNumber;
  HomePage(this.castedVoteNumber,this.voteID,this.memberID);

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
              voteID: voteID,
              memberID: memberID,
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