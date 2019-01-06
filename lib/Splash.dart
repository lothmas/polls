import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stats/main.dart';

class SplashView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
        debugShowCheckedModeBanner: false,

        color: Colors.white,
        home: Builder(
          builder: (context) => new _SplashContent(),
        ),
        routes: <String, WidgetBuilder>{
          '/main': (BuildContext context) => new Home()}
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
    var duration = const Duration(seconds: 1);
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