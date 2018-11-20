import 'package:flutter/material.dart';
import 'package:stats/TrendingMasterObject.dart';
import 'package:stats/PlaceholderWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';



const PrimaryColor = const Color(0x00000000);

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Trending();
  }
}

class _Trending extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.white)
  ];

  @override
  Widget build(BuildContext context) {
    final menuButton = new PopupMenuButton<int>(
      onSelected: (int i) {},
      itemBuilder: (BuildContext ctx) {},
      child: new Image(
        image: new AssetImage("images/notification.png"),
        width: 34,
        height: 34,
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
          elevation: 10,
          title: new Text(
            'Trending',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.6)),
          ),
          leading: new Image(
            image: new AssetImage("images/menu.png"),
            width: 24,
            height: 24,
            color: null,
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
          ),
          actions: [
            menuButton,
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped, // new
          currentIndex: _currentIndex, // new
          items: [
            new BottomNavigationBarItem(
              icon: new Image(
                image: new AssetImage("images/home.png"),
                width: 24,
                height: 24,
                color: null,
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
              ),
              title: new Text(
                'home',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.withOpacity(0.6)),
              ),
            ),
            new BottomNavigationBarItem(
              icon: new Image(
                image: new AssetImage("images/search.png"),
                width: 24,
                height: 24,
                color: null,
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
              ),
              title: new Text(
                'search',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.withOpacity(0.6)),
              ),
            ),
            new BottomNavigationBarItem(
              icon: new Image(
                image: new AssetImage("images/createVote.png"),
                width: 24,
                height: 24,
                color: null,
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
              ),
              title: new Text(
                'create_poll',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.withOpacity(0.6)),
              ),
            ),
            new BottomNavigationBarItem(
              icon: new Image(
                image: new AssetImage("images/profile.png"),
                width: 32,
                height: 32,
                color: null,
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
              ),
              title: new Text(
                'profile',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.withOpacity(0.6)),
              ),
            )
          ],
        ),

//        body: Column(
//        children: <Widget>[
//          Image.asset('images/plan.jpg')
//
//        ],
//        ),

        body: Center(
            child: new Container(
                child: new SingleChildScrollView(
                    child: new ConstrainedBox(
                      constraints: new BoxConstraints(),
                      child: new Column(children: <Widget>[

                      new FutureBuilder<TrendingMasterObject>(
                          future: fetchPost(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          TrendingMasterObject trendingMasterObject =snapshot.data;
                          List<TrendingList> trending=trendingMasterObject.trendingList;
                          for(TrendingList trendingList in trending){
                            return new Image.network(
                              trendingList.mainDisplay,
                            );
                        return new Container(
                        padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                        color: Colors.grey,
                        child: new Text(
                        'Cast Light life style Here',
                        textDirection: TextDirection.ltr,
                        style: new TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        ),
                        ),
                        );
                        return new Container(
                        child: new Text(
                        'Hi There ? this is sample plaid app using flutter sdk and dart programming language, devceloper is Hammad Tariq'
                        'this is sample Flutter app example Code'
                        'Flutter Column Widget scrollable using SingleChildScrollView'
                        'I am just loving Flutter SDK'
                        'Flutter scrollview example using Single Child Scroll View'
                        'flutter fixing bottom overflow by xx pixels in flutter'
                        'Flutter scrollable layout example'
                        'Flutter app SingleChildScrollView Example ',
                        textDirection: TextDirection.ltr,
                        style: new TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                        ),
                        ),
                        );
                          }
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }

                        // By default, show a loading spinner
                        return CircularProgressIndicator();
                      },
                    ),






                      ]),
                    )))
        ),
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

Future<TrendingMasterObject> fetchPost() async {
  Map<String, String> body = {
    'memberID': '7',
  };
  String requestUrl = "http://192.168.88.223:8090/trending";
  final response = await http.post(
    requestUrl,
    body: body,
  );
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    try {
      return TrendingMasterObject.fromJson(json.decode(response.body));
      String dsfsd="sdf";
    } catch (e) {}
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
