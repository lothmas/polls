import 'package:flutter/material.dart';
import 'package:stats/Trending.dart';
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
    imageCache.clear();
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
    Trending homeTrending=new Trending();
    final menuButton = new PopupMenuButton<int>(
      onSelected: (int i) {},
      itemBuilder: (BuildContext ctx) {},
      child: new Image(
        image: new AssetImage("images/notification.png"),
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
            'Trending',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.6)),
          ),
          leading: new Image(
            image: new AssetImage("images/menu.png"),
            width: 20,
            height: 20,
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
          child: FutureBuilder<TrendingMasterObject>(
            future: fetchPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                TrendingMasterObject trendingMasterObject = snapshot.data;
                List<TrendingList> trending = trendingMasterObject.trendingList;
                return new ConstrainedBox(
                  constraints: new BoxConstraints(),
                  child: new Column(children: homeTrending.homeTrendingList(trending,context)),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        ))),
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
  //192.168.88.223   work: 192.168.1.40
  String requestUrl = "http://192.168.1.40:8090/trending";
  final response = await http.post(
    requestUrl,
    body: body,
  );
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    try {
      return TrendingMasterObject.fromJson(json.decode(response.body));
    } catch (e) {}
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
