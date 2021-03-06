import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/hidden_drawer/screen_hidden_drawer.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';
import 'package:stats/Splash.dart';
import 'package:stats/Trending.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:stats/create_vote_pages.dart';
import 'package:stats/login_screen_1.dart';
import 'package:stats/time_line/time_line.dart';

const PrimaryColor = const Color(0x00000000);

//void main() => runApp(Home());

void main() async {

  final FirebaseApp app = await FirebaseApp.configure(
    name: 'test',
    options: FirebaseOptions(
      googleAppID: Platform.isIOS
          ? '1:886993795008:ios:d682d7e2aee1bf4a'
          : '1:886993795008:android:d682d7e2aee1bf4a',
//      gcmSenderID: '159623150305',
      apiKey: 'AIzaSyDYE13jkl283raYvE0MfmZfZOVwCsmHd70',
      projectID: 'polls-223422',
    ),
  );
  final FirebaseStorage storage =
      FirebaseStorage(app: app, storageBucket: 'gs://polls-223422.appspot.com');
  bool loggedIn = false;
  String userUID;
  FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
    if (user != null) {
      loggedIn = true;
      userUID = user.uid;
    }

  });

  if(loggedIn){
    Home(userUID);
  }else{
    runApp(SplashView());
  }
}

class Home extends StatefulWidget {
  String userUID;
  Home(this.userUID, {this.storage});

  final FirebaseStorage storage;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    // imageCache.clear();
    return _Trending(userUID,storage: storage);
  }
}

class _Trending extends State<Home> {

  List<ScreenHiddenDrawer> itens = new List();
  List<ScreenHiddenDrawer> itens1 = new List();

  @override
  void initState() {
//    initiateFacebookLogin();
    Trending homeTrending = new Trending();
    itens1.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Create Poll",
          colorTextUnSelected: Colors.grey,
          colorLineSelected: Colors.teal,
          colorTextSelected: Colors.blueGrey,
          key: UniqueKey(),
        ),
        Center(child: new CreateVotes())));
    itens.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Trending",
          colorTextUnSelected: Colors.grey,
          colorLineSelected: Colors.teal,
          colorTextSelected: Colors.blueGrey,
          key: UniqueKey(),
        ),
        Center(
            child: new Container(
                child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('votes').orderBy('creationDateTime', descending: true).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {

              return new ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return new Card(
                    child: Column(
                      children:
                          homeTrending.homeTrendingList(context, document,userUID),
                    ),
                  );
                }).toList(),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        )))));

    itens.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Timeline",
          colorTextUnSelected: Colors.grey,
          colorLineSelected: Colors.teal,
          colorTextSelected: Colors.blueGrey,
          key: UniqueKey(),
        ),
        Center(child: new TimeLine())
    ));

    itens.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Favourite",
          colorTextUnSelected: Colors.grey,
          colorLineSelected: Colors.teal,
          colorTextSelected: Colors.blueGrey,
          key: UniqueKey(),
        ),
        Container(
          color: Colors.orange,
          child: Center(
            child: Text(
              "Favourite",
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
          ),
        )));

    itens.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Notifications",
          colorTextUnSelected: Colors.grey,
          colorLineSelected: Colors.teal,
          colorTextSelected: Colors.blueGrey,
          key: UniqueKey(),
        ),
        Container(
          color: Colors.red,
          child: Center(
            child: Text(
              "Notifications",
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
          ),
        )));

    for (int a = 1; a < itens.length; a++) {
      itens1.add(itens.elementAt(a));
    }

    super.initState();
  }

  int _currentIndex = 0;
   String userUID;

  _Trending(this.userUID,{this.storage});

  final FirebaseStorage storage;

  String errorMsg;

  @override
  Widget build(BuildContext context) {
    Trending homeTrending = new Trending();
    final menuButton = new PopupMenuButton<int>(
      onSelected: (int i) {},
      itemBuilder: (BuildContext ctx) {},
      child: new Image(
        image: new AssetImage("images/notification.png"),
        width: 42,
        height: 42,
        color: null,
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
      ),
    );

    Future<void> signOut1(BuildContext context) async {}

    final dropDownMenu = PopupMenuButton<DropDownMenuList>(
      onSelected: (DropDownMenuList i) async {
        if (i.title == 'log-out') {
          await FirebaseAuth.instance.signOut();
          Navigator.pushReplacement(
            context,
            new MaterialPageRoute(builder: (context) => new LoginScreen1()),
          );
        }
      },
      itemBuilder: (BuildContext context) {
        return choices.skip(0).map((DropDownMenuList choice) {
          return PopupMenuItem<DropDownMenuList>(
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
    );

    var bottomNavigationBar2 = buildBottomNavigationBar();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        bottomNavigationBar: bottomNavigationBar2,
        body: new HiddenDrawerMenu(
          initPositionSelected: 0,
          screens:
              _currentIndex == 0 ? itens : _currentIndex == 2 ? itens1 : null,
          backgroundColorMenu: Colors.white,
          iconMenuAppBar: Image(
            image: new AssetImage("images/menu.png"),
            width: 42,
            height: 42,
            color: null,
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
          ),
          //    backgroundContent: DecorationImage((image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
          //    whithAutoTittleName: true,
          //    styleAutoTittleName: TextStyle(color: Colors.red),
          actionsAppBar: <Widget>[menuButton, dropDownMenu],
          //    backgroundColorContent: Colors.blue,
          backgroundColorAppBar: Colors.blueGrey,
          //    elevationAppBar: 4.0,
          //    tittleAppBar: Center(child: Icon(Icons.ac_unit),),
          //    enableShadowItensMenu: true,
          isDraggable: false,
          backgroundMenu: DecorationImage(
              image: ExactAssetImage("images/background.jpg"),
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
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
            'create poll',
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
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;

//      if (index == 2) {
//        Navigator.push(
//          context,
//          new MaterialPageRoute(
//              builder: (context) => new CreateVote()),
//        );
//      }
    });
  }
}

class DropDownMenuList {
  const DropDownMenuList({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<DropDownMenuList> choices = const <DropDownMenuList>[
  const DropDownMenuList(title: 'log-out', icon: Icons.outlined_flag),
  // const DropDownMenuList(title: 'share', icon: Icons.share),
//  const DropDownMenuList(title: 'block', icon: Icons.block),
  // const DropDownMenuList(title: 'not-interested', icon: Icons.not_interested),
//  const DropDownMenuList(title: 'Train', icon: Icons.directions_railway),
//  const DropDownMenuList(title: 'Walk', icon: Icons.directions_walk),
];

class DropDownMenuListCard extends StatelessWidget {
  const DropDownMenuListCard({Key key, this.choice}) : super(key: key);

  final DropDownMenuList choice;

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
