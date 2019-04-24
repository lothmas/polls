//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//import 'package:folding_cell/folding_cell.dart';
//import 'package:stats/Trending.dart';
//
////void main() => runApp(MaterialApp(
////    home: SafeArea(
////        child: Scaffold(body: Material(child: FoldingCellSimpleDemo())))));
//
///// Example 1 folding cell inside [Container]
//class FoldingCellSimpleDemo extends StatelessWidget {
//  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();
//  DocumentSnapshot document;
//  FoldingCellSimpleDemo(DocumentSnapshot document){
//    this.document=document;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      color: Color(0xFF2e282a),
//      alignment: Alignment.topCenter,
//      child: SimpleFoldingCell(
//          key: _foldingCellKey,
//          frontWidget: _buildFrontWidget(context),
//          innerTopWidget: _buildInnerTopWidget(),
//          innerBottomWidget: _buildInnerBottomWidget(),
//          cellSize: Size(MediaQuery.of(context).size.width, 700),
//          padding: EdgeInsets.all(15),
//          animationDuration: Duration(milliseconds: 300),
//          borderRadius: 10,
//          onOpen: () => print('cell opened'),
//          onClose: () => print('cell closed')),
//    );
//  }
//
//  Widget _buildFrontWidget(BuildContext context) {
//    Trending homeTrending = new Trending();
//    return Container(
//        color: Color(0xFFffcd3c),
//        alignment: Alignment.center,
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Column(
//              children:
//              homeTrending.homeTrendingList(context, document,'MMM111'),
//            ),
//            FlatButton(
//              onPressed: () => _foldingCellKey?.currentState?.toggleFold(),
//              child: Text(
//                "Open",
//              ),
//              textColor: Colors.white,
//              color: Colors.indigoAccent,
//              splashColor: Colors.white.withOpacity(0.5),
//            )
//          ],
//        ));
//  }
//
//  Widget _buildInnerTopWidget() {
//    return Container(
//        color: Color(0xFFff9234),
//        alignment: Alignment.center,
//        child: Text("TITLE",
//            style: TextStyle(
//                color: Color(0xFF2e282a),
//                fontFamily: 'OpenSans',
//                fontSize: 20.0,
//                fontWeight: FontWeight.w800)));
//  }
//
//  Widget _buildInnerBottomWidget() {
//    return Container(
//      color: Color(0xFFecf2f9),
//      alignment: Alignment.bottomCenter,
//      child: Padding(
//        padding: EdgeInsets.only(bottom: 10),
//        child: FlatButton(
//          onPressed: () => _foldingCellKey?.currentState?.toggleFold(),
//          child: Text(
//            "Close",
//          ),
//          textColor: Colors.white,
//          color: Colors.indigoAccent,
//          splashColor: Colors.white.withOpacity(0.5),
//        ),
//      ),
//    );
//  }
//}
//
///// Example 2 folding cell inside [ListView]
//class FoldingCellListViewDemo extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      color: Color(0xFF2e282a),
//      child: ListView.builder(
//          itemCount: 100,
//          itemBuilder: (context, index) {
//            return SimpleFoldingCell(
//                frontWidget: _buildFrontWidget(index),
//                innerTopWidget: _buildInnerTopWidget(index),
//                innerBottomWidget: _buildInnerBottomWidget(index),
//                cellSize: Size(MediaQuery.of(context).size.width, 125),
//                padding: EdgeInsets.all(15),
//                animationDuration: Duration(milliseconds: 300),
//                borderRadius: 10,
//                onOpen: () => print('$index cell opened'),
//                onClose: () => print('$index cell closed'));
//          }),
//    );
//  }
//
//  Widget _buildFrontWidget(int index) {
//    return Builder(
//      builder: (BuildContext context) {
//        return Container(
//            color: Color(0xFFffcd3c),
//            alignment: Alignment.center,
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Text("CARD - $index",
//                    style: TextStyle(
//                        color: Color(0xFF2e282a),
//                        fontFamily: 'OpenSans',
//                        fontSize: 20.0,
//                        fontWeight: FontWeight.w800)),
//                FlatButton(
//                  onPressed: () {
//                    SimpleFoldingCellState foldingCellState =
//                    context.ancestorStateOfType(
//                        TypeMatcher<SimpleFoldingCellState>());
//                    foldingCellState?.toggleFold();
//                  },
//                  child: Text(
//                    "Open",
//                  ),
//                  textColor: Colors.white,
//                  color: Colors.indigoAccent,
//                  splashColor: Colors.white.withOpacity(0.5),
//                )
//              ],
//            ));
//      },
//    );
//  }
//
//  Widget _buildInnerTopWidget(int index) {
//    return Container(
//        color: Color(0xFFff9234),
//        alignment: Alignment.center,
//        child: Text("TITLE - $index",
//            style: TextStyle(
//                color: Color(0xFF2e282a),
//                fontFamily: 'OpenSans',
//                fontSize: 20.0,
//                fontWeight: FontWeight.w800)));
//  }
//
//  Widget _buildInnerBottomWidget(int index) {
//    return Builder(builder: (context) {
//      return Container(
//        color: Color(0xFFecf2f9),
//        alignment: Alignment.bottomCenter,
//        child: Padding(
//          padding: EdgeInsets.only(bottom: 10),
//          child: FlatButton(
//            onPressed: () {
//              SimpleFoldingCellState foldingCellState = context
//                  .ancestorStateOfType(TypeMatcher<SimpleFoldingCellState>());
//              foldingCellState?.toggleFold();
//            },
//            child: Text(
//              "Close",
//            ),
//            textColor: Colors.white,
//            color: Colors.indigoAccent,
//            splashColor: Colors.white.withOpacity(0.5),
//          ),
//        ),
//      );
//    });
//  }
//}
