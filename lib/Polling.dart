import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stats/NomineeMasterObject.dart';
import 'package:stats/Trending.dart';
import 'package:stats/TrendingMasterObject.dart';
import 'package:stats/PlaceholderWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const PrimaryColor = const Color(0x00000000);

String voteIDs;

class Polling extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    imageCache.clear();
    return _Trending();
  }
   String voteID;
  Polling({this.voteID}){
    voteIDs=voteID;
  }


}

class _Trending extends State<Polling> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.white)
  ];

  @override
  Widget build(BuildContext context) {
    Trending PollingTrending=new Trending();
    final menuButton = new PopupMenuButton<int>(
      onSelected: (int i) {},
      itemBuilder: (BuildContext ctx) {},
      child: new Image(
        image: new AssetImage("images/vote.png"),
        width: 32,
        height: 32,
        color: null,
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
      ),
      //Logo
    );
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          title: new Text(
            'Nominies',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.6)),
          ),
          leading: GestureDetector(child: Image(
            image: new AssetImage("images/exit.png"),
            width: 14,
            height: 14,
            color: null,
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
          ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            menuButton,
          ],
        ),


        body: App(),
//            new Container(
//
//                  child: FutureBuilder<NomineeMasterObject>(
//                    future: fetchPost(voteIDs),
//                    builder: (context, snapshot) {
//                      if (snapshot.hasData) {
//                        NomineeMasterObject nomineeMasterObject = snapshot.data;
//                        List<NomineesEntityList> nomineeList = nomineeMasterObject.nomineesEntityList;
//
//                        return new NomineeGrid1(nomineeList: nomineeList);
//                      } else if (snapshot.hasError) {
//                        return Text("${snapshot.error}");
//                      }
//
//                      // By default, show a loading spinner
//                      return CircularProgressIndicator();
//                    },
//                  ),
//                ),

     //   gridView,
      ),
    );
  }

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
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: 4,
          childAspectRatio: 1.0,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            child: new Card(
              elevation: 5.0,
              child: new Container(
                alignment: Alignment.center,
                child: Image(
                  image: new NetworkImage(nomineeList.elementAt(index).nomineeImage),

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



Future<NomineeMasterObject> fetchPost(String voteID) async {
  Map<String, String> body = {
    'voteID': voteID,
  };
  //192.168.88.223   work: 192.168.1.40
  String requestUrl = "http://192.168.1.40:8090/nominees";
  final response = await http.post(
    requestUrl,
    body: body,
  );
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    try {
      return NomineeMasterObject.fromJson(json.decode(response.body));
     // nomineesList = nomineeMasterObject.nomineesEntityList;

    } catch (e) {}
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  Color caughtColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DragBox(Offset(0.0, 0.0), 'Box One', Colors.blueAccent),
        DragBox(Offset(100.0, 0.0), 'Box Two', Colors.orange),
        DragBox(Offset(200.0, 0.0), 'Box Three', Colors.lightGreen),
        DragBox(Offset(300.0, 0.0), 'Box Four', Colors.redAccent),
        Positioned(
          left: 100.0,
          bottom: 0.0,
          child: DragTarget(
            onAccept: (Color color) {
              caughtColor = color;
            },
            builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
                ) {
              return Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  color: accepted.isEmpty ? caughtColor : Colors.grey.shade200,
                ),
                child: Center(
                  child: Text("Drag Here!"),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class DragBox extends StatefulWidget {
  final Offset initPos;
  final String label;
  final Color itemColor;

  DragBox(this.initPos, this.label, this.itemColor);

  @override
  DragBoxState createState() => DragBoxState();
}

class DragBoxState extends State<DragBox> {
  Offset position = Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: position.dx,
        top: position.dy,
        child: Draggable(
          data: widget.itemColor,
          child: Container(
            width: 100.0,
            height: 100.0,
            color: widget.itemColor,
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          onDraggableCanceled: (velocity, offset) {
            setState(() {
              position = offset;
            });
          },
          feedback: Container(
            width: 120.0,
            height: 120.0,
            color: widget.itemColor.withOpacity(0.5),
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ));
  }
}


