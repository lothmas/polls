import 'package:flutter/material.dart';
import 'package:stats/Polling.dart';
import 'package:stats/TrendingMasterObject.dart';
import 'package:badge/badge.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:quiver/async.dart';
import 'package:super_tooltip/super_tooltip.dart';

class Trending {
  var youtube = new FlutterYoutube();

  List<Widget> homeTrendingList(
      List<TrendingList> trending, BuildContext context) {
    var assetImage = new AssetImage("images/cast.png");
    var cast = new Image(image: assetImage,width: 18,height: 18,fit: BoxFit.fill,alignment: Alignment.center,);

    RenderBox renderBox = context.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    var targetGlobalCenter = renderBox
        .localToGlobal(renderBox.size.center(Offset.zero), ancestor: overlay);

    List<Widget> list = new List();

    for (TrendingList trendingList in trending) {
      list.add(Container(
        color: Colors.transparent,
        height: 12.0,
      ));
      list.add(Row(
        children: [
          Container(
            color: Colors.transparent,
            child: ClipOval(
                child: Image.network(
              trendingList.profilePic,
              fit: BoxFit.fill,
              width: 75.0,
              height: 75.0,
            )),
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
                  trendingList.title,
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
                        trendingList.owner,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.lightBlueAccent),
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
                            child: Image(
                              image: new AssetImage("images/lock.png"),
                              width: 18,
                              height: 18,
                              color: null,
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            width: 58,
                          ),
                          Container(
                            child: Image(
                              image: new AssetImage("images/trending.png"),
                              width: 18,
                              height: 18,
                              color: null,
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            width: 58,
                          ),
                          GestureDetector(
                            onTap: () {
                              list.add(new Tooltip(
                                  message: "Hello World",
                                  child: new Text("foo")));
                            },
                            child: Image(
                              image: new AssetImage("images/info.png"),
                              width: 18,
                              height: 18,
                              color: null,
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            ],
          ),
          Container(
            color: Colors.transparent,
            width: 40.0,
          ),
          Container(
              color: Colors.grey,
              child: Badge.before(
//                      (trending.getVotesCasted()+" | "+trending.getAllowedVoteNumber()) );
                value: trendingList.votesCasted.toString() +
                    ' | ' +
                    trendingList.allowedVoteNumber.toString(),
                color: Colors.blueGrey, // value to show inside the badge
                // child: new Text("button") // text to append (required)
              )),
        ],
      ));

      list.add(Container(
        color: Colors.transparent,
        height: 12.0,
      ));

      list.add(Text(trendingList.description, textAlign: TextAlign.left));
      list.add(Container(
        color: Colors.transparent,
        height: 20.0,
      ));
      if (trendingList.descriptionType == 1) {
        list.add(new Image.network(
          trendingList.mainDisplay,
          height: 270,
          color: null,
          fit: BoxFit.fill,
          alignment: Alignment.topLeft,
        ));
      }
      else if (trendingList.descriptionType == 2 &&
          trendingList.mainDisplay.contains("https://www.youtube.com")) {
        list.add(Container(
            height: 270,

            child:FlutterYoutube.playYoutubeVideoByUrl(
            apiKey: "AIzaSyC-OhlIOcjW_WBqBbDUVKJF4qN4MMSNL8c",
            videoUrl: trendingList.mainDisplay,
            autoPlay: false, //default falase
            fullScreen: false
            ,
          //default false

            )),);

      }
      else if (trendingList.descriptionType == 2) {
        list.add(new Chewie(
          new VideoPlayerController.network(trendingList.mainDisplay),
          //aspectRatio: 3 / 2,

          autoPlay: false,
          looping: true,
          autoInitialize: true,

//          placeholder: Image(
//            image: new AssetImage("images/plan.jpg"),
//            width: 18,
//            height: 18,
//            color: null,
//            fit: BoxFit.scaleDown,
//            alignment: Alignment.center,
//          ),
        ));
      }


      list.add(
        new Container(
          width: 500.0,
          height: 22.0,
          //   padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
//          decoration: new BoxDecoration(color: Colors.white30, boxShadow: [
//            new BoxShadow(
//              color: Colors.white,
//              blurRadius: 20.0,
//            ),
//          ]),
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new Row(
                 // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      //color: Colors.purple,
                        child: Badge.before(
                          color: Colors.transparent,
                          borderColor: Colors.transparent,
                          textStyle: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold),
                          value: countdown(DateTime.parse(trendingList.time)) +
                              " :ago",
                        )),
                  ],
                ),
              ]),
        ),
      );



      list.add(
        Divider(),
      );

      list.add(
        new Container(
          width: 500.0,
          height: 50.0,
          //   padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
          decoration: new BoxDecoration(color: Colors.white30, boxShadow: [
            new BoxShadow(
              color: Colors.black26,
              blurRadius: 20.0,
            ),
          ]),
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
//                    Container(
//
//                      height: cast.height,
//                      width: cast.width,
//                      child: new FlatButton(
////              onPressed: castClick(),
//                        child: new ConstrainedBox(
//                          constraints: new BoxConstraints.expand(),
//                          child: cast,
//                        ),
//                      ),
//                    ),
          GestureDetector(
                      child: Image(
                        image: new AssetImage("images/cast.png"),
                        width: 18,
                        height: 18,
                        color: null,

                        alignment: Alignment.center,
                      ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Polling()),
              );
            },
                    ),
                    Container(
                      child: Image(
                        image: new AssetImage("images/trending.png"),
                        width: 18,
                        height: 18,
                        color: null,
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                      ),
                    ),
                    Container(
                      child: Image(
                        image: new AssetImage("images/share.png"),
                        width: 18,
                        height: 18,
                        color: null,
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      );

      list.add(
        Divider(),
      );
    }

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
