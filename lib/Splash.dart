import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stats/login_screen_1.dart';
import 'package:stats/main.dart';

class SplashView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    bool loggedIn =false;
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      if(user!=null) {
        loggedIn = true;
      }
    });
    return new MaterialApp(
        debugShowCheckedModeBanner: false,

        color: Colors.white,
        home: Builder(
          builder: (context) => new _SplashContent(),
        ),
        routes: <String, WidgetBuilder>{
          '/main': (BuildContext context) => loggedIn ? Home(): Scaffold(body: new LoginScreen1())}
    );
  }
}

class _SplashContent extends StatefulWidget{

  @override
  _SplashContentState createState() => new _SplashContentState();
}

class _SplashContentState extends State<_SplashContent>
    with SingleTickerProviderStateMixin {

  var _iconAnimationController;
  var _iconAnimation;

  startTimeout() async {
    var duration = const Duration(seconds: 2);
    return new Timer(duration, handleTimeout);
  }

  void handleTimeout() {
    Navigator.pushReplacementNamed(context, "/main");
  }

  @override
  void initState() {
    super.initState();

    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 20000));

    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeIn);
    _iconAnimation.addListener(() => this.setState(() {}));

    _iconAnimationController.forward();

    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Image(
          image: new AssetImage("images/loader2.gif"),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        )
    );
  }
}