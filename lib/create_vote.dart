import 'dart:math';
import 'dart:ui' show lerpDouble;

//import 'package:badge/badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stats/card_data.dart';
import 'package:stats/tag.dart';
import 'package:stats/tag1.dart';
import 'package:stats/text_focus_helper.dart';
import 'package:stats/vote_by_dropdown.dart';

class CreateVote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double scrollPercent = 0.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Spacer for status bar
          new Container(
            width: double.infinity,
            height: 20.0,
          ),

          // Cards
          new Expanded(
            child: new CardFlipper(
                cards: demoCards,
                onScroll: (double scrollPercent) {
                  setState(() => this.scrollPercent = scrollPercent);
                }),
          ),

          // Scroll Indicator
          new BottomBar(
            cardCount: demoCards.length,
            scrollPercent: scrollPercent,
          ),
        ],
      ),
    );
  }
}

class CardFlipper extends StatefulWidget {
  final List<CardViewModel> cards;
  final Function onScroll;

  CardFlipper({
    this.cards,
    this.onScroll,
  });

  @override
  _CardFlipperState createState() => new _CardFlipperState();
}

class _CardFlipperState extends State<CardFlipper>
    with TickerProviderStateMixin {
  double scrollPercent = 0.0;
  Offset startDrag;
  double startDragPercentScroll;
  double finishScrollStart;
  double finishScrollEnd;
  AnimationController finishScrollController;

  @override
  void initState() {
    super.initState();

    finishScrollController = new AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    )
      ..addListener(() {
        setState(() {
          scrollPercent = lerpDouble(
              finishScrollStart, finishScrollEnd, finishScrollController.value);

          if (widget.onScroll != null) {
            widget.onScroll(scrollPercent);
          }
        });
      })
      ..addStatusListener((AnimationStatus status) {});
  }

  void _onPanStart(DragStartDetails details) {
    startDrag = details.globalPosition;
    startDragPercentScroll = scrollPercent;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final currDrag = details.globalPosition;
    final dragDistance = currDrag.dx - startDrag.dx;
    final singleCardDragPercent = dragDistance / context.size.width;

    setState(() {
      scrollPercent = (startDragPercentScroll +
              (-singleCardDragPercent / widget.cards.length))
          .clamp(0.0, 1.0 - (1 / widget.cards.length));
      print('percentScroll: $scrollPercent');

      if (widget.onScroll != null) {
        widget.onScroll(scrollPercent);
      }
    });
  }

  void _onPanEnd(DragEndDetails details) {
    finishScrollStart = scrollPercent;
    finishScrollEnd =
        (scrollPercent * widget.cards.length).round() / widget.cards.length;
    finishScrollController.forward(from: 0.0);

    setState(() {
      startDrag = null;
      startDragPercentScroll = null;
    });
  }

  List<Widget> _buildCards() {
    int index = -1;
    return widget.cards.map((CardViewModel viewModel) {
      ++index;
      return _buildCard(viewModel, index, widget.cards.length, scrollPercent);
    }).toList();
  }

  Matrix4 _buildCardProjection(double scrollPercent) {
    // Pre-multiplied matrix of a projection matrix and a view matrix.
    //
    // Projection matrix is a simplified perspective matrix
    // http://web.iitd.ac.in/~hegde/cad/lecture/L9_persproj.pdf
    // in the form of
    // [[1.0, 0.0, 0.0, 0.0],
    //  [0.0, 1.0, 0.0, 0.0],
    //  [0.0, 0.0, 1.0, 0.0],
    //  [0.0, 0.0, -perspective, 1.0]]
    //
    // View matrix is a simplified camera view matrix.
    // Basically re-scales to keep object at original size at angle = 0 at
    // any radius in the form of
    // [[1.0, 0.0, 0.0, 0.0],
    //  [0.0, 1.0, 0.0, 0.0],
    //  [0.0, 0.0, 1.0, -radius],
    //  [0.0, 0.0, 0.0, 1.0]]
    final perspective = 0.002;
    final radius = 1.0;
    final angle = scrollPercent * pi / 8;
    final horizontalTranslation = 0.0;
    Matrix4 projection = new Matrix4.identity()
      ..setEntry(0, 0, 1 / radius)
      ..setEntry(1, 1, 1 / radius)
      ..setEntry(3, 2, -perspective)
      ..setEntry(2, 3, -radius)
      ..setEntry(3, 3, perspective * radius + 1.0);

    // Model matrix by first translating the object from the origin of the world
    // by radius in the z axis and then rotating against the world.
    final rotationPointMultiplier = angle > 0.0 ? angle / angle.abs() : 1.0;
    print('Angle: $angle');
    projection *= new Matrix4.translationValues(
            horizontalTranslation + (rotationPointMultiplier * 300.0),
            0.0,
            0.0) *
        new Matrix4.rotationY(angle) *
        new Matrix4.translationValues(0.0, 0.0, radius) *
        new Matrix4.translationValues(
            -rotationPointMultiplier * 300.0, 0.0, 0.0);

    return projection;
  }

  Widget _buildCard(
    CardViewModel viewModel,
    int cardIndex,
    int cardCount,
    double scrollPercent,
  ) {
    final cardScrollPercent = scrollPercent / (1 / cardCount);
    final parallax = scrollPercent - (cardIndex / widget.cards.length);

    return new FractionalTranslation(
      translation: new Offset(cardIndex - cardScrollPercent, 0.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Transform(
          transform: _buildCardProjection(cardScrollPercent - cardIndex),
          child: new CreateVoteCard(
            viewModel: viewModel,
            parallaxPercent: parallax,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onPanStart,
      onHorizontalDragUpdate: _onPanUpdate,
      onHorizontalDragEnd: _onPanEnd,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: _buildCards(),
      ),
    );
  }
}

class CreateVoteCard extends StatelessWidget {
  final CardViewModel viewModel;
  final double
      parallaxPercent; // [0.0, 1.0] (0.0 for all the way right, 1.0 for all the way left)

  CreateVoteCard({
    this.viewModel,
    this.parallaxPercent = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // Background
        new ClipRRect(
          borderRadius: new BorderRadius.circular(10.0),
          child: new Container(
            child: new FractionalTranslation(
              translation: new Offset(parallaxPercent * 2.0, 0.0),
              child: new OverflowBox(
                maxWidth: double.infinity,
                child: new Image.asset(
                  viewModel.backdropAssetPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),


        // Content
        viewModel.pageNumber == 1 ? page1():viewModel.pageNumber== 2? page2():viewModel.pageNumber== 3? page3():true
       ],
    );
  }

  Column page1() {
    FocusNode _focusNodeFirstName = new FocusNode();
    return new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
//          Row(
//          crossAxisAlignment: CrossAxisAlignment.end,
//          children: [
////            Container(
////              color: Colors.transparent,
////              width: 10.0,
////            ),
//            Container(
//              //   padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
////          decoration: new BoxDecoration(color: Colors.white30, boxShadow: [
////            new BoxShadow(
////              color: Colors.white,
////              blurRadius: 20.0,
////            ),
////          ]),
//              color: Colors.transparent,
//              child: ClipOval(
//                child: FadeInImage.assetNetwork(
//                  placeholder: 'images/loader.gif',
//                  image: "https://www.goldderby.com/wp-content/uploads/2016/12/Voice-Logo.jpg",
//                  fit: BoxFit.fill,
//                  width: 50.0,
//                  height: 50.0,
//                ),
//              ),
//            ),
//            Container(
//              color: Colors.transparent,
//              width: 10.0,
//            ),
//            Column(
//              children: [
//                Container(
//                  child: new Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: [
//                      Container(
//                        color: Colors.transparent,
//                        child: Text(
//                          'owner:  ',
//                          textAlign: TextAlign.left,
//                        ),
//                      ),
//                      Container(
//                        color: Colors.transparent,
//                        child: Text(
//                          "fifa.world.cup",
//                          textAlign: TextAlign.left,
//                          style: TextStyle(color: Colors.teal),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                Container(
//                  color: Colors.transparent,
//                  height: 7,
//                ),
//
//
//                Container(
//                  child: new Column(
////                    mainAxisAlignment: MainAxisAlignment.center,
//                      children: [
//                        new Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceAround,
//                          children: [
//                            Container(
//                              color: Colors.transparent,
//                              width: 20,
//                            ),
//                            Container(
//                              color: Colors.transparent,
//                              width: 58,
//                            ),
//                            Container(
//                              color: Colors.transparent,
//                              width: 58,
//                            ),
//                          ],
//                        ),
//                      ]),
//                ),
//              ],
//            ),
//            Container(
//              color: Colors.transparent,
//              width: 30,
//            ),
//            new Align(
//                child: Container(
//                    color: Colors.black12,
//                    child: Badge.right(
////                      (trending.getVotesCasted()+" | "+trending.getAllowedVoteNumber()) );
//                        value: '0' + ' | ' + '0',
//                        color: Colors.white70,
//                        // value to show inside the badge
//                        child: new Text("") // text to append (required)
//                    ))),
//          ],
//        ),



          new ListTile(
            leading: const Icon(Icons.title),
            title: new TextField(style: new TextStyle( color: Colors.white70, fontSize: 12.0,),
              decoration: new InputDecoration(
                hintText: "Poll Title",
              ),
            ),
          ),
        new ListTile(
          leading: const Icon(Icons.description),
          title: new TextField(style: new TextStyle( color: Colors.white70, fontSize: 12.0,),
            decoration: new InputDecoration(
              hintText: "Poll Description",
            ),
          ),
        ),
        new ListTile(
          leading: const Icon(Icons.confirmation_number),
          title: new TextField( style: new TextStyle( color: Colors.white70, fontSize: 12.0,),
            decoration: new InputDecoration(
              hintText: "Allowed Number of Polls Per Voter",
            ),
          ),
        ),
        new ListTile(
          leading: Text("vote by:",style: new TextStyle(  fontSize: 14.0,fontWeight: FontWeight.bold)),
          title: SettingsWidget(),
        ),
        const Divider(
          height: 1.0,
        ),

//
//        new ListTile(
//     //     leading: const Icon(Icons.cloud_upload),
//          title: const Text('Upload Poll Image / Video',style:  TextStyle( color: Colors.white70, fontSize: 8.0,fontWeight: FontWeight.bold),) ,
//
//        ),
            Container(
              color: Colors.transparent,
              height: 30,
            ),
          Text('Upload Poll Image / Video',style:  TextStyle( color: Colors.black, fontSize: 11.0,fontWeight: FontWeight.bold),),
        Container(
          width: 50.0,
          height: 70.0,
          child: FadeInImage.assetNetwork(
            placeholder: 'images/picker.png',
            image: "",
              fit: BoxFit.fill,

          ),
        ),




//          new ListTile(
//            leading: const Icon(Icons.today),
//            title: const Text('Birthday'),
//            subtitle: const Text('February 20, 1980'),
//          ),
//          new ListTile(
//            leading: const Icon(Icons.group),
//            title: const Text('Contact group'),
//            subtitle: const Text('Not specified'),
//          )
//


        ],
      );
  }


  Widget page2() {
    new MyApp();
  }

  Widget page3() {
     new VoteNeededData();
  }
}

class BottomBar extends StatelessWidget {
  final int cardCount;
  final double scrollPercent;

  BottomBar({
    this.cardCount,
    this.scrollPercent,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      child: new Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Center(
                child: new Icon(
                  Icons.arrow_forward,
                  color: Colors.white70,
                ),
              ),
            ),
            new Expanded(
              child: new Center(
                child: new Container(
                  width: double.infinity,
                  height: 5.0,
                  child: new ScrollIndicator(
                    cardCount: cardCount,
                    scrollPercent: scrollPercent,
                  ),
                ),
              ),
            ),
            new Expanded(
              child: new Center(
                child: new Icon(
                  Icons.arrow_back,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScrollIndicator extends StatelessWidget {
  final int cardCount;
  final double scrollPercent;

  ScrollIndicator({
    this.cardCount,
    this.scrollPercent,
  });

  @override
  Widget build(BuildContext context) {
    return new CustomPaint(
      painter: new ScrollIndicatorPainter(
        cardCount: cardCount,
        scrollPercent: scrollPercent,
      ),
      child: new Container(),
    );
  }
}

class ScrollIndicatorPainter extends CustomPainter {
  final int cardCount;
  final double scrollPercent;
  final Paint trackPaint;
  final Paint thumbPaint;

  ScrollIndicatorPainter({
    this.cardCount,
    this.scrollPercent,
  })  : trackPaint = new Paint()
          ..color = Colors.amber
          ..style = PaintingStyle.fill,
        thumbPaint = new Paint()
          ..color = Colors.blueGrey
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    // Draw track
    canvas.drawRRect(
      new RRect.fromRectAndCorners(
        new Rect.fromLTWH(
          0.0,
          0.0,
          size.width,
          size.height,
        ),
        topLeft: new Radius.circular(3.0),
        topRight: new Radius.circular(3.0),
        bottomLeft: new Radius.circular(3.0),
        bottomRight: new Radius.circular(3.0),
      ),
      trackPaint,
    );

    // Draw thumb
    final thumbWidth = size.width / cardCount;
    final thumbLeft = scrollPercent * size.width;

    Path thumbPath = new Path();
    thumbPath.addRRect(
      new RRect.fromRectAndCorners(
        new Rect.fromLTWH(
          thumbLeft,
          0.0,
          thumbWidth,
          size.height,
        ),
        topLeft: new Radius.circular(3.0),
        topRight: new Radius.circular(3.0),
        bottomLeft: new Radius.circular(3.0),
        bottomRight: new Radius.circular(3.0),
      ),
    );

    // Thumb shape
    canvas.drawPath(
      thumbPath,
      thumbPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
