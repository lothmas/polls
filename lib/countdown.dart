//import 'package:flutter/material.dart';
//import 'package:flutter_countdown/flutter_countdown.dart';
//
//const int BEGIN_COUNT = 60;
//const int END_COUNT = 0;
//const String DEFAULT_LABEL = 'touched begin count down';
//
//class CountDown1 extends StatefulWidget {
//
//  @override
//  State<StatefulWidget> createState() {
//    return new _ExampleState();
//  }
//}
//
//class _ExampleState extends State<CountDown1> {
//  AnimationController _controller;
//
//  _onPressCountDown(AnimationController ctr) {
//    if (ctr.isAnimating) {
//      return Future.value(false);
//    }
//    // todo: something
//    return Future.value(true);
//  }
//
//  _countDownStatusListener(AnimationStatus state) {
//    if (state == AnimationStatus.forward) {
//      _controller?.stop(canceled: true);
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      body: new Card(
//          child: new Center(
//              child: CountDown(
//                beginCount: BEGIN_COUNT,
//                endCount: END_COUNT,
//                renderLabel: (count) {
//                  if (count == BEGIN_COUNT) {
//                    return DEFAULT_LABEL;
//                  }
//                  return '$count';
//                },
//                onPress: (ctr) => _onPressCountDown(ctr),
//                statusListener: (state) => _countDownStatusListener(state),
//                refs: (ctr) { _controller = ctr; },
//              )
//          )),
//    );
//  }
//}