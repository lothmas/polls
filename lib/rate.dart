import 'package:flutter/material.dart';
import 'package:stats/start_rating.dart';

//void main() => runApp(StarRatingDemo());

class StarRatings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Star Rating Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int starLength = 5;
  double _rating = 0.0;

  void _incrementHalfStar() {
    setState(() {
      _rating += 0.5;
      if (_rating > starLength) {
        _rating = starLength.toDouble();
      }
    });
  }

  void _decrementHalfStar() {
    setState(() {
      _rating -= 0.5;
      if (_rating < 0.0) {
        _rating = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 1,
          ),
//          Row(
//          //  crossAxisAlignment: CrossAxisAlignment.b,
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//
//            Text('Star Rating: $_rating / ${starLength.toDouble()}',
//                style: TextStyle(
//                    fontSize: 12,
//                    fontWeight: FontWeight.bold,
//                    color: Colors.grey)),
//            Text('polls: 5448',
//                style: TextStyle(
//                    fontSize: 12,
//                    fontWeight: FontWeight.bold,
//                    color: Colors.grey)),
//          ],),

//          Container(
//            height: 3,
//          ),
          Row(
            children: <Widget>[
              StarRating(
                color: Colors.amber,
                mainAxisAlignment: MainAxisAlignment.start,
                length: starLength,
                rating: _rating,
                between: 5.0,
                starSize: 25.0,
                onRaitingTap: (rating) {
                  print('Clicked rating: $rating / $starLength');
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              Row(

                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 20,
                  ),
                  Container(
                    height: 28,
                    width: 28,
                    child: FloatingActionButton(
                      onPressed: _decrementHalfStar,
                      heroTag: "Decrement",
                      tooltip: 'Decrement',
                      backgroundColor: Colors.blueGrey,
                      mini: true,
                      child: Icon(Icons.arrow_drop_down),
                    ),
                  ),
                  Container(
                    width: 10,
                  ),
                  Container(
                    height: 28,
                    width: 28,
                    child: FloatingActionButton(
                      heroTag: "increment",
                      onPressed: _incrementHalfStar,
                      backgroundColor: Colors.blueGrey,
                      tooltip: 'Increment',
                      mini: true,
                      child: Icon(Icons.arrow_drop_up),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
