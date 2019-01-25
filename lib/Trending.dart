import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:stats/Polling.dart';
import 'package:badge/badge.dart';
import 'package:chewie/chewie.dart';
import 'package:stats/emoji.dart';
import 'package:stats/image_display.dart';
import 'package:stats/radio.dart';
import 'package:stats/radio_yes_no.dart';
import 'package:stats/rate.dart';
import 'package:stats/yesnomaybe.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class Trending {
  var youtube = new FlutterYoutube();

  List<Widget> homeTrendingList(
      BuildContext context, DocumentSnapshot document) {
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
                    builder: (context) => new Polling(
                        voteID: document.documentID,
                        voteBy: document['voteBy'],
                        voteType: document['voteType'])),
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
                '12 hrs ago',
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
          width: 10.0,
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
          width: 10.0,
        ),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 1.0),
              color: Colors.transparent,
              child: Text(
                document['title'],
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.transparent,
              height: 5.0,
            ),
            Container(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.transparent,
                    child: Text(
                      'owner:  ',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Text(
                      document['owner'],
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.transparent,
              height: 7,
            ),
            Container(
//          //   padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
//          decoration: new BoxDecoration(color: Colors.white30, boxShadow: [
//            new BoxShadow(
//              color: Colors.white,
//              blurRadius: 20.0,
//            ),
//          ]),
              child: new Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          color: Colors.transparent,
                          width: 20,
                        ),
                        Container(
//                          child: Image(
//                            image: new AssetImage("images/lock.png"),
//                            width: 18,
//                            height: 18,
//                            color: null,
//                            fit: BoxFit.scaleDown,
//                            alignment: Alignment.center,
//                          ),
                            ),
                        Container(
                          color: Colors.transparent,
                          width: 58,
                        ),
                        Container(
//                          child: Image(
//                            image: new AssetImage("images/trending.png"),
//                            width: 18,
//                            height: 18,
//                            color: null,
//                            fit: BoxFit.scaleDown,
//                            alignment: Alignment.center,
//                          ),
                            ),
                        Container(
                          color: Colors.transparent,
                          width: 58,
                        ),
//                        GestureDetector(
//                          onTap: () {
//                            list.add(new Tooltip(
//                                message: "Hello World",
//                                child: new Text("foo")));
//                          },
//                          child: Image(
//                            image: new AssetImage("images/info.png"),
//                            width: 18,
//                            height: 18,
//                            color: null,
//                            fit: BoxFit.scaleDown,
//                            alignment: Alignment.center,
//                          ),
//                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
        Container(
          color: Colors.transparent,
          width: 30,
        ),
        new Align(
            child: Container(
                color: Colors.black12,
                child: Badge.right(
//                      (trending.getVotesCasted()+" | "+trending.getAllowedVoteNumber()) );
                    value:
                        '0' + ' | ' + document['allowedVoteNumber'].toString(),
                    color: Colors.blueGrey, // value to show inside the badge
                    child: new Text("") // text to append (required)
                    ))),
      ],
    ));

    list.add(Container(
      color: Colors.transparent,
      height: 8.0,
    ));
    list.add(
      Divider(),
    );
    list.add(Container(
      padding: const EdgeInsets.all(10),
      width: c_width,
      child: new Column(
        children: <Widget>[
          Text(
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
      height: 8.0,
    ));
    if (document['postType'] == 1) {
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
    } else if (document['postType'] == 2 &&
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
    } else if (document['postType'] == 2) {
      list.add(new Chewie(
        new VideoPlayerController.network(document['postPath']),
        aspectRatio: 1,
        autoPlay: false,
        looping: false,
        autoInitialize: true,
      ));
    }
    if (document['voteBy'] == 4) {
      list.add(Container(
        height: 55,
        child: StarRatingDemo(),
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
        Container(height: 110, child: Emoji()),
      );
    }
    if (document['voteBy'] == 7) {
      list.add(
        Container(height: 65, child: new YesNoMaybe()),
      );
    }
    if (document['voteBy'] == 8) {
      list.add(
        Container(height: 55, child: new LikeDisLike()),
      );
    }
    list.add(
      new Container(
        width: 500.0,
      ),
    );

    list.add(
      Divider(),
    );

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
          bottomNavigationBar: bottomAppBar,
        ),
      ),
    );

    return list;
  }

  String countdown(DateTime dateVoteCreated) {
    if (DateTime.now().difference(dateVoteCreated).inMinutes < 60) {
      int mins = DateTime.now().difference(dateVoteCreated).inMinutes;
      if (mins < 0) {
        mins = -mins;
        if (mins < 60) {
          mins = 60 - mins;
        } else {
          mins = mins % 60;
        }
      }
      return mins.toString() + " mins";
    } else if (DateTime.now().difference(dateVoteCreated).inHours < 24) {
      return DateTime.now().difference(dateVoteCreated).inHours.toString() +
          " hrs";
    } else if (DateTime.now().difference(dateVoteCreated).inDays <= 6) {
      return DateTime.now().difference(dateVoteCreated).inDays.toString() +
          " days";
    } else if (DateTime.now().difference(dateVoteCreated).inDays >= 7 &&
        DateTime.now().difference(dateVoteCreated).inDays <= 31) {
      int days = DateTime.now().difference(dateVoteCreated).inDays;
      return (days / 7).toString().substring(0, 1) + " weeks";
    } else if (DateTime.now().difference(dateVoteCreated).inDays > 31) {
      return (DateTime.now().difference(dateVoteCreated).inDays / 30)
              .toString()
              .substring(0, 2) +
          " months";
    }
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
