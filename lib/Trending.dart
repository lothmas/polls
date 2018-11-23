import 'package:flutter/material.dart';
import 'package:stats/TrendingMasterObject.dart';
import 'package:badge/badge.dart';

class Trending{

  List<Widget> homeTrendingList(List<TrendingList> trending) {

      List<Widget> list = new List();

      for (TrendingList trendingList in trending) {
        if (trendingList.descriptionType == 1) {
          list.add( Container(
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
                    color: Colors.transparent,
                    child: Text(
                      trendingList.owner,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.lightBlueAccent),
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.transparent,
                width: 50.0,
              ),
              Container(
                //color: Colors.purple,
                  child: Badge.before(
                    value: "Text", // value to show inside the badge
                    // child: new Text("button") // text to append (required)
                  )
              ),
            ],
          ));

          list.add( Container(
            color: Colors.transparent,
            height: 12.0,
          ));

          list.add(Text(trendingList.description,textAlign: TextAlign.left));
          list.add( Container(
            color: Colors.transparent,
            height: 20.0,
          ));

          list.add(new Image.network(
            trendingList.mainDisplay,
            height: 270,
            color: null,
            fit: BoxFit.fill,
            alignment: Alignment.topLeft,
          ));

//      list.add(new Container(
//        color: Colors.black,
//        child: BottomNavigationBar(
//
//          items: <BottomNavigationBarItem>[
//            new BottomNavigationBarItem(
//                icon: const Icon(Icons.poll), title: new Text("ff")),
//            new BottomNavigationBarItem(
//                icon: const Icon(Icons.work), title: new Text("")),
//            new BottomNavigationBarItem(
//                icon: const Icon(Icons.face), title: new Text(""))
//          ],
//          fixedColor: Colors.white,
//
//        ),
//      ));


//          list.add(
//
//              );


          list.add(Divider(),);

          list.add( new Container(
            width: 500.0,
            height: 50.0,
         //   padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
            decoration: new BoxDecoration(
                color: Colors.white30,
                boxShadow: [new BoxShadow(
                  color: Colors.grey,
                  blurRadius: 20.0,
                ),]
            ),
            child: new Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Row(

                    children: [
                      Container(
                        color: Colors.transparent,
                        width: 20.0,
                      ),
                      Container(child: Image(
                        image: new AssetImage("images/cast.png"),
                        width: 30,
                        height: 30,
                        color: null,
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                      ),
                      ),
                      Container(
                        color: Colors.transparent,
                        width: 100.0,
                      ),
                      Container(child: Image(
                        image: new AssetImage("images/trending.png"),
                        width: 30,
                        height: 30,
                        color: null,
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,

                      ),

                      ),

                      Container(
                        color: Colors.transparent,
                        width: 100.0,
                      ),
                      Container(child: Image(
                        image: new AssetImage("images/share.png"),
                        width: 30,
                        height: 30,
                        color: null,
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,

                      ),
                      ),
                    ],
                  ),
                ]
            ),
          ),);

          list.add(Divider(),);
        }
      }

      return list;
    }
}
