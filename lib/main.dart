import 'package:flutter/material.dart';
import 'package:stats/PlaceholderWidget.dart';

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
      child:   new Image(
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
          title: new Text('Trending', textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.6)),),
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
        body:  _children[_currentIndex], // new
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped, // new
          currentIndex: _currentIndex, // new
          items: [
            new BottomNavigationBarItem(
              icon: new Image(
                image: new AssetImage("images/trending.png"),
                width: 24,
                height: 24,
                color: null,
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
              ),
              title: new Text('trending', textAlign: TextAlign.left,style: TextStyle(fontSize:12,fontWeight: FontWeight.bold,color: Colors.blueGrey.withOpacity(0.6)),),

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
              title: new Text('search', textAlign: TextAlign.left,style: TextStyle(fontSize:12,fontWeight: FontWeight.bold,color: Colors.blueGrey.withOpacity(0.6)),),

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
              title: new Text('create_poll', textAlign: TextAlign.left,style: TextStyle(fontSize:12,fontWeight: FontWeight.bold,color: Colors.blueGrey.withOpacity(0.6)),),

            ),
            new BottomNavigationBarItem(
                icon: new Image(
                  image: new AssetImage("images/profile1.png"),
                  width: 24,
                  height: 24,
                  color: null,
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                ),
                title: new Text('profile', textAlign: TextAlign.left,style: TextStyle(fontSize:12,fontWeight: FontWeight.bold,color: Colors.blueGrey.withOpacity(0.6)),),

            )
          ],
        ),

           // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      if(index==1){

      }
      _currentIndex = index;
    });
  }
}
