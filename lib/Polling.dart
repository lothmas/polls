import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stats/NomineeMasterObject.dart';
import 'package:stats/Nominees.dart';
import 'package:stats/drag.dart';
import 'package:stats/draggable_order_image/reorderimage.dart';
import 'package:stats/multiple_selection/multipleselection.dart';

const PrimaryColor = const Color(0x00000000);

String voteIDs;
int voteBy1;
int voteType1;

class Polling extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    //   imageCache.clear();
    return _Trending();
  }

  String voteID;
  int voteBy;
  int voteType;

  Polling({this.voteID, this.voteBy, this.voteType}) {
    voteIDs = voteID;
    voteBy1 = voteBy;
    voteType1 = voteType;
  }
}

class _Trending extends State<Polling> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Nominees PollingTrending = new Nominees();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          backgroundColor: Colors.blueGrey,
          elevation: 2,
          title: Text(
            "Nominees",
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 12.0, color: Colors.black),
          ),
          leading: GestureDetector(
              child: Image(
                image: new AssetImage("images/exit.png"),
                width: 14,
                height: 14,
                color: null,
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
              ),
              onTap: () {
                Navigator.pop(context);
              }),
        ),
        body:
//
            new Stack(
          children: <Widget>[
            Center(
                child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('nominees')
                  .where('vote_id', isEqualTo: voteIDs)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                List<NomineesEntityList> nomineesList = new List();
                if (snapshot.hasData) {
                  snapshot.data.documents.map((DocumentSnapshot document) {
                    NomineesEntityList nominee = new NomineesEntityList();
                    nominee.nomineeName = null!=document['nominee_name']?document['nominee_name']:'';
                    nominee.id = null!=document['id']?document['id']:0;
                    nominee.nomineesDescription = null!=document['nominee_description']?document['nominee_description']:'';
                    nominee.nomineeImage = null!=document['nominee_media']?document['nominee_media']:'';
                    nomineesList.add(nominee);
                  }).toList();
                  List<String> items = new List();

                  //voteType 1(one_select) 2 (order) 3(multiple_select)
                  //voteBy 1(text) 2(image) 3(video)
                  if (voteType1 == 2 && voteBy1 == 2) {
                    // return new ReOrderGrid().reorder(nomineesList, voteType1);
                    return new DraggableReOrderImage(nomineesList, voteBy1);
                  }
                  if (voteType1 == 2 && voteBy1 == 1) {
                    List<NomineesEntityList> nomineesList1 = new List();
                    int count = 0;
                    for (NomineesEntityList nominee in nomineesList) {
                      NomineesEntityList nominee1 = new NomineesEntityList();
                      nominee1.nomineeName = nominee.nomineeName;
                      nominee1.id = nominee.id;
                      nominee1.nomineesDescription =
                          nominee.nomineesDescription;
                      nominee1.nomineeImage = "images/nominee_images/nominee" +
                          count.toString() +
                          ".jpg";
                      nomineesList1.add(nominee1);
                      count++;
                    }
                    return new DraggableReOrderImage(nomineesList1, voteBy1);
                  } else if (voteType1 == 1 && (voteBy1 == 1 || voteBy1 == 2)) {
                    return new SingleSelectDrag(nomineesList, voteBy1, "images/background.jpg");
                  } else if (voteType1 == 3) {
                    return new MultipleSelection1(nomineesList, voteBy1);
                  }
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner
                return CircularProgressIndicator();
              },
            )),
          ],
        ),
      ), //
      //   gridView,
    );
  }

  Map<int, NomineesEntityList> pairs = {};

  bool validated = false;

  int score = 0;

  void onTabTapped(int index) {
    setState(() {
      if (index == 1) {}
      _currentIndex = index;
    });
  }
}

class App extends StatefulWidget {
  @override
  List<Widget> nomieeGrid;

  App({List<Widget> nomieeGrid}) {
    this.nomieeGrid = nomieeGrid;
  }

  AppState createState() => AppState(nomieeGrid: nomieeGrid);
}

class AppState extends State<App> {
  Color caughtColor = Colors.grey;
  List<Widget> nomieeGrid;

  AppState({List<Widget> nomieeGrid}) {
    this.nomieeGrid = nomieeGrid;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: nomieeGrid,
    );
  }
}
