library flip_panel;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:stats/Graph.dart';
import 'package:stats/Polling.dart';
import 'package:badge/badge.dart';
import 'package:chewie/chewie.dart';
import 'package:stats/emoji.dart';
import 'package:stats/flip_clock.dart';
import 'package:stats/image_display.dart';
import 'package:stats/radio.dart';
import 'package:stats/radio_yes_no.dart';
import 'package:stats/rate.dart';
import 'package:stats/yesnomaybe.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef Widget DigitBuilder(BuildContext, int);

class Trending {
  var youtube = new FlutterYoutube();
  final bool debugMode = true;

  List<Widget> homeTrendingList(BuildContext context, DocumentSnapshot document, String memberID) {
    int numberOfVotes=0 ;

//    Firestore.instance.collection("casted_votes")
//        .where("member_id", isEqualTo: memberID)
//        .where("vote_id", isEqualTo: document.documentID)
//        .getDocuments().then((string) {
//      if(string.documents.length!=0) {
//        string.documents.forEach((doc) => numberOfVotes=numberOfVotes+1);
//      }
//    });

//    StreamBuilder<QuerySnapshot>(
//      stream: Firestore.instance
//          .collection('casted_votes')
//          .where('vote_id', isEqualTo: document.documentID.toString())
//          .where('member_id', isEqualTo: memberID)
//          .snapshots(),
//      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//        if (snapshot.hasData) {
//          numberOfVotes=1;
//        } else if (snapshot.hasError) {
//          return Text("${snapshot.error}");
//        }
//
//        // By default, show a loading spinner
//        return CircularProgressIndicator();
//      },
//    );
print('voteId: '+document.documentID);
    Duration _duration = new Duration();
    try {
      DateTime dDay = document['startDateTime'];
      _duration = dDay.difference(DateTime.now());
    } catch (e) {}

    if (document['enabled'] == true) {
      double c_width = MediaQuery.of(context).size.width * 1;
      var assetImage = new AssetImage("images/cast.png");

      List<Widget> list = new List();

      var bottomAppBar = BottomAppBar(
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
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new RandomizedRadialChartExample()),
                );
              },
            ),
            Column(
              children: <Widget>[
                document['voteBy'] != 4 &&
                        document['voteBy'] != 5 &&
                        document['voteBy'] != 6 &&
                        document['voteBy'] != 7 &&
                        document['voteBy'] != 8
                    ? IconButton(
                        icon: Image.asset(
                          "images/cast.png",
                          width: 22.0,
                          height: 22.0,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new Polling(
                                    voteID: document.documentID,
                                    voteBy: document['voteBy'],
                                    voteType: document['voteType'])),
                          );
                        },
                      )
                    : Text(""),
                Container(
                    //height: 10.0,
                    ),
                Text(
                  countdownlapsedTime(document['creationDateTime']),
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            PopupMenuButton<Choice>(
              //      onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.skip(0).map((Choice choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(choice.icon),
                          onPressed: () {},
                        ),
                        Text(choice.title)
                      ],
                    ),
                  );
                }).toList();
              },
            ),
          ],
        ),
      );

      list.add(Container(
        color: Colors.transparent,
        height: 12.0,
      ));
      list.add(Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            color: Colors.transparent,
            width: 3.0,
          ),
          Container(
            //   padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
//          decoration: new BoxDecoration(color: Colors.white30, boxShadow: [
//            new BoxShadow(
//              color: Colors.white,
//              blurRadius: 20.0,
//            ),
//          ]),
            color: Colors.transparent,
            child: ClipOval(
              child: FadeInImage.assetNetwork(
                placeholder: 'images/loader.gif',
                image: document['profile_pic'],
                fit: BoxFit.fill,
                width: 75.0,
                height: 75.0,
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            width: 1.0,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 1.0),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        document['title'].toString().toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 10,
                ),
                Container(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.transparent,
                        width: 3.0,
                      ),
                      Row(
                        children: <Widget>[
                          document['loginProvider'] == 1
                              ? SvgPicture.asset(
                                  'images/facebook.svg',
                                  height: 15.0,
                                  width: 15.0,
                                  allowDrawingOutsideViewBox: true,
                                )
                              : document['loginProvider'] == 2
                                  ? SvgPicture.asset(
                                      'images/google.svg',
                                      height: 15.0,
                                      width: 15.0,
                                      allowDrawingOutsideViewBox: true,
                                    )
                                  : document['loginProvider'] == 3
                                      ? SvgPicture.asset(
                                          'images/twitter.svg',
                                          height: 25.0,
                                          width: 25.0,
                                          allowDrawingOutsideViewBox: true,
                                        )
                                      : Text(''),
                          Container(
                            color: Colors.transparent,
                            width: 4.0,
                          ),
                          Container(
                            color: Colors.transparent,
                            child: Text(
                              document['owner'].toString().toLowerCase(),
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(color: Colors.teal, fontSize: 11),
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            width: 8.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              new Container(
                                  child: Container(
                                      child: Container(
                                          color: Colors.transparent,
                                          child: StreamBuilder<QuerySnapshot>(
                                            stream: Firestore.instance
                                                .collection('casted_votes')
                                                .where('vote_id', isEqualTo: document.documentID)
                                                .where('member_id', isEqualTo: 'MMM111')
                                                .snapshots(),
                                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                                              if (snapshot.hasData) {
                                                return  Container(
                                                    color: Colors.transparent,
                                                    child: GestureDetector(
                                                      child: Badge.before(
//                      (trending.getVotesCasted()+" | "+trending.getAllowedVoteNumber()) );
                                                        value: snapshot.data.documents.length.toString() +
                                                            ' | ' +
                                                            document['allowedVoteNumber']
                                                                .toString(),
                                                        textStyle: TextStyle(fontSize: 8),
                                                        borderColor: Colors.grey,
                                                        borderSize: 1.0,
                                                        color: Colors.white,
                                                        // value to show inside the badge
                                                        // text to append (required)
                                                      ),
                                                      onTap: () {
                                                        toolTip(
                                                            context,
                                                            'I show you if poll has started and currently live \'OR\' if closed. Currenctly its LIVE that\'s what the play icon stands for',
                                                            'Allowed Polls: ' +
                                                                document['allowedVoteNumber']
                                                                    .toString());
                                                      },
                                                    ));
                                              } else if (snapshot.hasError) {
                                                return Text("${snapshot.error}");
                                              }
                                              return Text("");

                                            },
                                          )))),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 6,
                ),
              ],
            ),
          )),
          Container(
            color: Colors.transparent,
            width: 5,
          ),
        ],
      ));
      list.add(
        Container(
          color: Colors.transparent,
          height: 5,
        ),
      );
      list.add(Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
//          Container(
//            color: Colors.transparent,
//            width: 30,
//          ),
          document['private_voter'] == null
              ? Container(
                  child: GestureDetector(
                      child: Text(
                        "public poll 🔓   ",
                        style: TextStyle(fontSize: 11),
                      ),
                      onTap: () {
                        toolTip(
                            context,
                            "I show you if this poll is restricted to selected users, or it's open to the public. Open green lock means open to the public",
                            "Poll is Public");
                      }),
                  decoration: _verticalDivider(),
                )
              : Container(
                  child: GestureDetector(
                      child: Text(
                        "private poll 🔓   ",
                        style: TextStyle(fontSize: 11),
                      ),
                      onTap: () {
                        toolTip(
                            context,
                            "I show you if this poll is restricted to selected users, or it's open to the public. Closed red lock means open to the public",
                            "Poll is Private");
                      }),
                  decoration: _verticalDivider(),
                ),
//          Container(
//            color: Colors.transparent,
//            width: 5,
//          ),
          document['private_report_viewer'] == null
                  ? Container(
                      child: GestureDetector(
                        child: Text('public report 📊   ',
                            style: TextStyle(fontSize: 11)),
                        onTap: () {
                          toolTip(
                              context,
                              'I show you if poll report is public \'OR\' private, if bulb is red it\'s private else its public. Report for this poll is PRIVATE  ',
                              'Private Poll Report');
                        },
                      ),
                      decoration: _verticalDivider(),
                    )
                  : Container(
                      child: GestureDetector(
                        child: Text('private report 📊   ',
                            style: TextStyle(fontSize: 11)),
                        onTap: () {
                          toolTip(
                              context,
                              'I show you if poll report is public \'OR\' private, if bulb is red it\'s private else its public. Report for this poll is PRIVATE  ',
                              'Private Poll Report');
                        },
                      ),
                      decoration: _verticalDivider(),
                    )
//          Container(
//            color: Colors.transparent,
//            width: 5,
//          ),
              ,
          Container(
            child: GestureDetector(
              child: Text('online 🔌   ', style: TextStyle(fontSize: 11)),
              onTap: () {
                toolTip(
                    context,
                    'I show you if poll has started and currently live \'OR\' if closed. Currenctly its LIVE that\'s what the play icon stands for',
                    'LIVE');
              },
            ),
            decoration: _verticalDivider(),
          ),
//          Container(
//            color: Colors.transparent,
//            width: 5,
//          ),
          document['anonymous'] == 1
              ? Container(
                  child: GestureDetector(
                    child: Text('anonymous  🕵️‍️  ',
                        style: TextStyle(fontSize: 11)),
                    onTap: () {
                      toolTip(
                          context,
                          'I show you if poll has started and currently live \'OR\' if closed. Currenctly its LIVE that\'s what the play icon stands for',
                          'Anonymous');
                    },
                  ),
                  decoration: _verticalDivider(),
                )
              : Text('')
        ],
      )));

      list.add(
        Divider(),
      );
      list.add(Container(
        padding: const EdgeInsets.all(10),
        width: c_width,
        child: new Column(
          children: <Widget>[
            document['description'] != '' && document['postPath'] == null
                ? Container(
                    child: Center(
                      child: Text(
                        document['description'],
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    height: 350.0,
//        width: MediaQuery.of(context).size.width - 100.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue,
                        image: DecorationImage(
                            image: new AssetImage("images/back9.jpg"),
                            fit: BoxFit.fill)),
                  )
                : Text(
                    document['description'],
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
          ],
        ),
      ));
//    list.add(
//      Row( children: [
//        Container(
//          color: Colors.transparent,
//          width: 10.0,
//        ),
//
//        Text(document['description'], textAlign: TextAlign.justify,softWrap: true),
//        Container(
//          color: Colors.transparent,
//          width: 10.0,
//        ),
//          ]
//      )
//    );
      list.add(Container(
        color: Colors.transparent,
        height: 2.0,
      ));

//      if(_duration.inSeconds==0) {

      if (null != document['postPath'] && document['postType'] == 1) {
        Image image = new Image.network(
          document['postPath'],
          //height: 270,
//        color: null,
//        fit: BoxFit.fill,
//        alignment: Alignment.topLeft,
        );

        //  image.height=

        list.add(GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                        new ImageScreen(document['title'], image)

//              new Image.network(
//                document['postPath'],
//                fit: BoxFit.none,
////                height: MediaQuery.of(context).size.width,
////                width: MediaQuery.of(context).size.width,
//                alignment: Alignment.center,
//              ),
                    ));
          },
          child: FadeInImage.assetNetwork(
            placeholder: 'images/loader.gif',
            image: document['postPath'],
          ),
        ));
      } else if (null != document['postPath'] &&
          document['postType'] == 2 &&
          document['postPath'].contains("https://www.youtube.com")) {
        list.add(
          Container(
              height: 270,
              child: FlutterYoutube.playYoutubeVideoByUrl(
                apiKey: "AIzaSyC-OhlIOcjW_WBqBbDUVKJF4qN4MMSNL8c",
                videoUrl: document['postPath'],
                autoPlay: false, //default falase
                fullScreen: false,
                //default false
              )),
        );
      } else if (null != document['postPath'] && document['postType'] == 2) {
        VideoPlayerController videoPlayerController1 =
            VideoPlayerController.network(document['postPath']);
        ChewieController _chewieController = ChewieController(
          videoPlayerController: videoPlayerController1,
          aspectRatio: 1,
          autoPlay: false,
          looping: true,
          autoInitialize: true,
        );
        list.add(new Chewie(
          controller: _chewieController,
        ));

//      Chewie(
//        new VideoPlayerController.network(document['postPath']),
//        aspectRatio: 1,
//        autoPlay: false,
//        looping: false,
//        autoInitialize: true,
//      ));
      }
//    }
//    else{
//    //  list.add(Image.asset("images/finalcountdown.jpg"));
//      }

      if (_duration.inSeconds <= 0) {
        if (document['voteBy'] == 4) {
          list.add(Container(
            height: 55,
            child: StarRatings(),
          ));
        }
        if (document['voteBy'] == 5) {
          list.add(Container(
            height: 40,
            child: CustomRadio(),
          ));
        }

        if (document['voteBy'] == 6) {
          list.add(
            Container(height: 78, child: Emoji()),
          );
        }
        if (document['voteBy'] == 7) {
          list.add(
            Container(height: 65, child: new YesNoMaybe(3)),
          );
        }
        if (document['voteBy'] == 8) {
          list.add(
            Container(height: 55, child: new LikeDisLike()),
          );
        }
      }
      list.add(
        new Container(
          width: 500.0,
        ),
      );

      list.add(
        Divider(),
      );
      if (_duration.inSeconds <= 0) {
        list.add(
          new Container(
            width: 500.0,
            height: 60.0,
            //   padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
//        decoration: new BoxDecoration(color: Colors.white30, boxShadow: [
//          new BoxShadow(
//            color: Colors.black26,
//            blurRadius: 20.0,
//          ),
//        ]),
            child: new Scaffold(
              resizeToAvoidBottomPadding: false,
              bottomNavigationBar: bottomAppBar,
            ),
          ),
        );
      } else {
        if (_duration.inSeconds != 0) {
          list.add(Container(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "images/count.png",
                width: 120,
              ),
              FlipClock.reverseCountdown(
                flipDirection: FlipDirection.down,
                duration: _duration,
                digitColor: Colors.white,
                backgroundColor: Colors.blueGrey,
                digitSize: 12.0,
                height: 15,
                width: 10,
                borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                //onDone: () => print('ih'),
              ),
            ],
          )));
        }
      }
      return list;
    } else {
      return null;
    }
  }

  String countdownlapsedTime(DateTime dateVoteCreated) {
    if (DateTime.now().difference(dateVoteCreated).inMinutes <= 60) {
      int mins = DateTime.now().difference(dateVoteCreated).inMinutes;
      if (mins > 1) {
        return mins.toString() + " mins ago";
      } else {
        return mins.toString() + " min ago";
      }
    } else if (DateTime.now().difference(dateVoteCreated).inMinutes > 60 &&
        DateTime.now().difference(dateVoteCreated).inMinutes <= 1440) {
      int hrs = DateTime.now().difference(dateVoteCreated).inHours;
      if (hrs > 1) {
        return hrs.toString() + " hrs ago";
      } else {
        return hrs.toString() + " hr ago";
      }
    } else if (DateTime.now().difference(dateVoteCreated).inMinutes > 1440 &&
        DateTime.now().difference(dateVoteCreated).inMinutes <= 10080) {
      int days = DateTime.now().difference(dateVoteCreated).inDays;
      if (days > 1) {
        return days.toString() + " days ago";
      } else {
        return days.toString() + " day ago";
      }
    } else if (DateTime.now().difference(dateVoteCreated).inMinutes > 10080 &&
        DateTime.now().difference(dateVoteCreated).inMinutes <= 43800) {
      int week = DateTime.now().difference(dateVoteCreated).inDays;
      if (week / 7 <= 2) {
        if (week % 7 == 0) {
          return (week / 7).toStringAsFixed(0) + " week ago";
        }
        return (week / 7).toStringAsFixed(1) + " weeks ago";
      } else {
        return (week / 7).toStringAsFixed(1) + " weeks ago";
      }
    } else if (DateTime.now().difference(dateVoteCreated).inMinutes > 43800 &&
        DateTime.now().difference(dateVoteCreated).inMinutes < 306600) {
      int months = DateTime.now().difference(dateVoteCreated).inDays;
      if ((months / 30).toInt() == 1) {
        return (months / 30).toInt().toString() + " month ago";
      } else {
        return (months / 30).toInt().toString() + " months ago";
      }
    }
  }

  _verticalDivider() => BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.blueGrey,
            width: 0.5,
          ),
        ),
      );

  void toolTip(BuildContext context, String message, String title) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: Colors.red,
      boxShadow: BoxShadow(
          color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0),
      backgroundGradient:
          LinearGradient(colors: [Colors.blueGrey, Colors.black]),
      isDismissible: false,
      duration: Duration(seconds: 6),
      icon: Icon(
        Icons.check,
        color: Colors.greenAccent,
      ),
      mainButton: FlatButton(
        onPressed: () {
          return null;
        },
        child: Text(
          title,
          style: TextStyle(color: Colors.amber),
        ),
      ),
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: Colors.blueGrey,
      titleText: Text(
        "what I do",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
            color: Colors.yellow[600],
            fontFamily: "ShadowsIntoLightTwo"),
      ),
      messageText: Text(
        message,
        style: TextStyle(
            fontSize: 11.0,
            color: Colors.green,
            fontFamily: "ShadowsIntoLightTwo"),
      ),
    ).show(context);
  }
}

class TooltipText extends StatelessWidget {
  final String text;
  final String tooltip;

  TooltipText({Key key, this.tooltip, this.text});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Text(text),
    );
  }

  void castClick() {}
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'favourite', icon: Icons.favorite),
  const Choice(title: 'share', icon: Icons.share),
//  const Choice(title: 'block', icon: Icons.block),
  const Choice(title: 'not-interested', icon: Icons.not_interested),
//  const Choice(title: 'Train', icon: Icons.directions_railway),
//  const Choice(title: 'Walk', icon: Icons.directions_walk),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
