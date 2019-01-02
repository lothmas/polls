import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stats/NomineeMasterObject.dart';
import 'package:stats/Nominees.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:stats/drag.dart';
import 'package:stats/draggable_order_grid/drag_and_drop_grid_reorder.dart';
import 'package:stats/draggable_order_image/reorderimage.dart';
import 'package:stats/draggable_order_list/drag_and_drop_list.dart';
import 'package:stats/dragreorder/OrderByDragging.dart';
import 'package:stats/main.dart';
import 'package:stats/multiple_selection/multipleselection.dart';
import 'package:stats/multipleorder/multiple_order.dart';
import 'package:stats/viewnominies/pages/homepage.dart';

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
        appBar: new AppBar(
          backgroundColor: Colors.blueGrey,
          elevation: 2,
          title: new Text(
            'Nominies',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.6)),
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
                Navigator.pop(
                  context);
              }),
        ),

        body:
//
            new Stack(
          children: <Widget>[
//              new Container(
//                decoration: new BoxDecoration(
//                  image: new DecorationImage(image: new AssetImage("images/background.jpg"), fit: BoxFit.cover,),
//                ),
//              ),
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
                    nominee.nomineeName = document['nominee_name'];
                    nominee.id = document['id'];
                    nominee.nomineesDescription =
                        document['nominee_description'];
                    nominee.nomineeImage = document['nominee_media'];
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
                    int count=0;
                    for (NomineesEntityList nominee in nomineesList) {
                      NomineesEntityList nominee1 = new NomineesEntityList();
                      nominee1.nomineeName = nominee.nomineeName;
                      nominee1.id = nominee.id;
                      nominee1.nomineesDescription = nominee.nomineesDescription;
                      nominee1.nomineeImage = "images/nominee_images/nominee"+count.toString()+".jpg";
                      nomineesList1.add(nominee1);
                      count++;
                    }
                    return new DraggableReOrderImage(nomineesList1, voteBy1);

//                    for (NomineesEntityList nominee in nomineesList) {
//                      items.add(nominee.nomineeName);
//                    }
//                    return new DragAndDropList<String>(
//                      items,
//                      itemBuilder: (BuildContext context, item) {
//                        return new SizedBox(
//                          child: new Card(
//                            child: new ListTile(
//                              title: new Text(item),
//                            ),
//                          ),
//                        );
//                      },
//                      onDragFinish: (before, after) {
//                        String data = items[before];
//                        items.removeAt(before);
//                        items.insert(after, data);
//                      },
//                      canBeDraggedTo: (one, two) => true,
//                      dragElevation: 8.0,
//                    );
                  } else if (voteType1 == 1 && (voteBy1 == 1 || voteBy1 == 2)) {
                    //    return new MultipleSelection1();

                    return new DropCityApp(
                        nomineesList, voteBy1, "images/background.jpg");
                  } else if (voteType1 == 3) {
                    return new MultipleSelection1(nomineesList, voteBy1);
                    // return new DraggableReOrderImage();
                    //return new OrderByDragging().drageableOrder(nomineesList, voteBy1);
                  }
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner
                return CircularProgressIndicator();
              },
            )

//          ),
                ),
          ],
        ),

//        floatingActionButtonLocation:
//        FloatingActionButtonLocation.endDocked,
//        floatingActionButton:  _buildButton(validated ? Icons.refresh : Icons.check,
//                validated ? _onClear : _onValidate)
        //  child: new Row(...),
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

class NomineeGrid1 extends StatelessWidget {
  const NomineeGrid1({
    Key key,
    @required this.nomineeList,
  }) : super(key: key);

  final List<NomineesEntityList> nomineeList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(1.0),
        itemCount: nomineeList.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.0,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            child: new Card(
              elevation: 5.0,
              child: new Container(
                alignment: Alignment.center,
                child: Image(
                  image: new NetworkImage(
                      nomineeList.elementAt(index).nomineeImage),
                  color: null,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
                //  child: new Text('Item $index'),
              ),
            ),
            onTap: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                child: new CupertinoAlertDialog(
                  title: new Column(
                    children: <Widget>[
                      new Text("GridView"),
                      new Icon(
                        Icons.favorite,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  content: new Text("Selected Item $index"),
                  actions: <Widget>[
                    new FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: new Text("OK"))
                  ],
                ),
              );
            },
          );
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
