import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stats/Trending.dart';
import 'package:stats/start_rating.dart';
import 'package:simple_countdown/simple_countdown.dart';
//void main() => runApp(StarRatingDemo());

class StarRatings extends StatelessWidget {
  final String voteID, memberID;

  StarRatings(this.voteID, this.memberID);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('casted_votes')
              .where('vote_id', isEqualTo: voteID)
              .where('member_id', isEqualTo: memberID)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            try {
              if (snapshot.hasData) {
                return MaterialApp(
                  home: MyHomePage(
                    castedVoteNumber:
                        double.parse(snapshot.data.documents.elementAt(0)['vote_number'].toString()),
                    voteID: voteID,
                    memberID: memberID,
                  ),
                  debugShowCheckedModeBanner: false,
                );
              } else if (snapshot.hasError) {}
            } catch (e) {
              return MaterialApp(
                home: MyHomePage(
                  title: 'Star Rating Demo Home Page',
                  castedVoteNumber: 0.0,
                  voteID: voteID,
                  memberID: memberID,
                ),
                debugShowCheckedModeBanner: false,
              );
            }
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  double castedVoteNumber;
  String voteID, memberID;

  MyHomePage(
      {Key key, this.title, this.castedVoteNumber, this.voteID, this.memberID})
      : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() =>
      _MyHomePageState(castedVoteNumber, castedVoteNumber, voteID, memberID);
}

class _MyHomePageState extends State<MyHomePage> {
  double castedVoteNumber;
  AnimationController _controller;
  String voteID, memberID;

  final int starLength = 5;
  double _rating;

  _MyHomePageState(
      this._rating, this.castedVoteNumber, this.voteID, this.memberID);

  int countDownValue = 15;

  void _incrementHalfStar() {
//    if(castedVoteNumber != 0.0 && castedVoteNumber!=0) {
    setState(() {
      countDownValue = 5;
      _rating += 0.5;
      if (_rating > starLength) {
        _rating = starLength.toDouble();
      }
    });

//    else{
////      Trending().toolTip(
////          context,
////          "You have already subimmited your poll, maximum permited polls have been reached.",
////          "Poll is Locked-in");
//    }
  }

  void _decrementHalfStar() {
//    if(castedVoteNumber != 0.0 && castedVoteNumber!=0) {
    setState(() {
      countDownValue = 5;
      _rating -= 0.5;
      if (_rating < 0.0) {
        _rating = 0.0;
      }
    });
//    }else{
////      Trending().toolTip(
////          context,
////          "I show you if this poll is restricted to selected users, or it's open to the public. Open green lock means open to the public",
////          "Poll is Public");
//    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 1,
          ),
          Row(
            children: <Widget>[
              StarRating(
                color: Colors.amber,
                mainAxisAlignment: MainAxisAlignment.start,
                length: starLength,
                rating: _rating,
                between: 5.0,
                starSize: 25.0,
                onRaitingTap: (rating) {
                  print('Clicked rating: $rating / $starLength');
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 20,
                  ),
                  Container(
                    height: 28,
                    width: 28,
                    child: FloatingActionButton(
                      onPressed: _decrementHalfStar,
                      heroTag: "Decrement",
                      tooltip: 'Decrement',
                      backgroundColor: Colors.blueGrey,
                      mini: true,
                      child: Icon(Icons.arrow_drop_down),
                    ),
                  ),
                  Container(
                    width: 10,
                  ),
                  Container(
                    height: 28,
                    width: 28,
                    child: FloatingActionButton(
                      heroTag: "increment",
                      onPressed: _incrementHalfStar,
                      backgroundColor: Colors.blueGrey,
                      tooltip: 'Increment',
                      mini: true,
                      child: Icon(Icons.arrow_drop_up),
                    ),
                  )
                ],
              )
            ],
          ),
          castedVoteNumber == 0 && _rating != 0
              ? Row(
                  //  crossAxisAlignment: CrossAxisAlignment.b,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('poll lock-in countdown:  ',
                        style: TextStyle(color: Colors.blueGrey)),
                    Center(
                      child: Countdown(
                        seconds: 15,
                        onFinish: () {
                          setState(() {
                            castedVoteNumber = _rating;
                            CollectionReference collectionReference =
                                Firestore.instance.collection('casted_votes');
                            DocumentReference docReferancew =
                                collectionReference.document();
                            docReferancew.setData({
                              "vote_id": voteID,
                              'member_id': memberID,
                              'vote_number': _rating,
                            });
                          });
                        },
                        textStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              : Text(''),
          Row(
            //  crossAxisAlignment: CrossAxisAlignment.b,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text('🗳 polls: ️',
                  style: TextStyle(color: Colors.black,fontSize: 11),),
              Container(
                  color: Colors.white,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection('casted_votes')
                        .where('vote_id', isEqualTo: voteID)
                        .snapshots(),
                    builder:
                        (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      try {
                        if (snapshot.hasData) {
                          return Text(snapshot.data.documents.length.toString());
                        } else if (snapshot.hasError) {}
                      } catch (e) {
                        return MaterialApp(
                          home: MyHomePage(
                            title: 'Star Rating Demo Home Page',
                            castedVoteNumber: 0.0,
                            voteID: voteID,
                            memberID: memberID,
                          ),
                          debugShowCheckedModeBanner: false,
                        );
                      }
                    },
                  )),
              Text('  ')
            ],
          ),
          Container(
            height: 3,
          ),
        ],
      ),
    );
  }

  _onPressCountDown(AnimationController ctr) {
    if (ctr.isAnimating) {
      return Future.value(false);
    }
    // todo: something
    return Future.value(true);
  }

  _countDownStatusListener(AnimationStatus state) {
    if (state == AnimationStatus.forward) {
      _controller?.stop(canceled: true);
    }
  }
}
