import 'package:flutter/material.dart';
import 'package:stats/NomineeMasterObject.dart';
import 'package:stats/dropcity/dragbox1.dart';
import 'package:stats/image_display.dart';
import 'package:stats/viewnominies/model/city.dart';

//void main() => runApp(new MyApp());
List<NomineesEntityList> nomineesList = new List();
int voteBy;
Map<int, NomineesEntityList> pairs = {};

bool validated = false;

int score = 0;

class MultipleSelection1 extends StatelessWidget {
  MultipleSelection1(List<NomineesEntityList> nomineesList1, int voteBy1) {
    nomineesList = nomineesList1;
    voteBy = voteBy1;
  }

  @override
  Widget build(BuildContext context) {
    return new MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool longPressFlag = false;
  List<int> indexList = new List();

  void longPress() {
    setState(() {
      if (indexList.isEmpty) {
        longPressFlag = false;
      } else {
        longPressFlag = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var main = new Scaffold(
      resizeToAvoidBottomPadding: false,

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildButton(validated ? 'images/refresh.png' : 'images/yes.png',
              validated ? _onClear : _onValidate),
          _buildButton1('images/vote.png', validated ? _onClear : _onValidate),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.blueGrey,

//        onTap: onTabTapped, // new
//        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: new Image(
              image: new AssetImage("images/yes.png"),
              width: 0,
              height: 0,
              color: null,
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
            ),
            title: new Text(
              '',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.withOpacity(0.6)),
            ),
          ),
          new BottomNavigationBarItem(
            icon: new Image(
              image: new AssetImage("images/vote.png"),
              width: 0,
              height: 0,
              color: null,
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
            ),
            title: new Text(
              '',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.withOpacity(0.6)),
            ),
          ),
        ],
      ),
      body: new ListView.builder(
        itemCount: nomineesList.length,
        itemBuilder: (
          context,
          index,
        ) {
          return new CustomWidget(
            index: index,
            longPressEnabled: longPressFlag,
            callback: () {
              if (indexList.contains(index)) {
                indexList.remove(index);
              } else {
                indexList.add(index);
              }
              longPress();
            },
          );
        },
      ),
      //Column(children: <Widget>[
//      Row(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          mainAxisSize: MainAxisSize.max,
//          children: [
////                  Container(
////                    color: Colors.transparent,
////                    height: 5,
////                    width: 5,
////                  ),
//
//
//            _buildButton(validated ? 'images/refresh.png':'images/yes.png',validated ? _onClear : _onValidate),
//            _buildButton1('images/vote.png',validated ? _onClear : _onValidate),
//
//
//          ]),
      // ],
    );

    Stack banner(Scaffold main) {
      return Stack(
        fit: StackFit.expand,
        children: <Widget>[
          main,
          Banner(
            message: "Multi-Select",
            location: BannerLocation.topEnd,
          ),
        ],
      );
    }

    return banner(main);

//      floatingActionButton: new FloatingActionButton(
//        onPressed: () {},
//        tooltip: 'Increment',
//        child: new Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
  }
}

void _onValidate() {
  //setState(() {
  score = 0;
  pairs.forEach((index, item) {
    if (item.id == index) {
      item.status = Status.correct;
      score++;
    } else
      item.status = Status.wrong;
  });
  validated = true;
//  }
  // );
}

void _onClear() {
//  setState(() {
  pairs.forEach((index, item) {
    item.status = Status.none;
    item.selected = false;
  });
  pairs.clear();
  validated = false;
//  }
//  );
}

Widget _buildButton(String icon, VoidCallback onPress) => new Padding(
    padding: new EdgeInsets.all(10.0),
    child: new FloatingActionButton(
        heroTag: "btn23",
        mini: true,
        backgroundColor: Colors.blueGrey,
        child: Image(
          image: new AssetImage(icon),
          width: 22,
          height: 22,
          color: null,
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
        ),
        onPressed: onPress));

Widget _buildButton1(String icon, VoidCallback onPress) => new Padding(
    padding: new EdgeInsets.all(10.0),
    child: new FloatingActionButton(
        heroTag: "btn44",
        mini: true,
        backgroundColor: Colors.blueGrey,
        child: Image(
          image: new AssetImage(icon),
          width: 32,
          height: 32,
          color: null,
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
        ),
        onPressed: onPress));

class CustomWidget extends StatefulWidget {
  final int index;
  final bool longPressEnabled;
  final VoidCallback callback;

  const CustomWidget(
      {Key key, this.index, this.longPressEnabled, this.callback})
      : super(key: key);

  @override
  _CustomWidgetState createState() => new _CustomWidgetState(index);
}

class _CustomWidgetState extends State<CustomWidget> {
  Map<int, NomineesEntityList> pairs = {};

  bool validated = false;

  int score = 0;
  bool selected = false;
  int index;

  _CustomWidgetState(this.index);

  @override
  Widget build(BuildContext context) {
    var image;
    if (voteBy == 1) {
      image = new AssetImage(
        "images/nominee_images/nominee" + index.toString() + ".jpg",
      );
    } else if (voteBy == 2) {
      image = new NetworkImage(
        nomineesList[index].nomineeImage,
//        fit: BoxFit.fitHeight,
//        width: 100,
      );
    }
    return new GestureDetector(
        onLongPress: () {
          setState(() {
            selected = !selected;
          });
          widget.callback();
        },
        child: Card(
          child: new Container(
            margin: new EdgeInsets.all(5.0),
            child: new ListTile(
              leading: (new Container(
                  width: 100.0,
                  height: 79.0,
                  alignment: Alignment.center,
                  foregroundDecoration: new BoxDecoration(
                      color: Color.fromRGBO(155, 85, 250, 0.0)),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'images/loader.gif',
                    image: nomineesList[index].nomineeImage,
                    width: 100.0,
                    height: 79.0,
                    fit: BoxFit.fill,
                  ))),
              title: new Text(
                nomineesList[index].nomineeName,
                style:
                    new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
              subtitle: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(nomineesList[index].nomineeName,
                        style: new TextStyle(
                            fontSize: 13.0, fontWeight: FontWeight.normal)),
                    new Text(
                        'Population: ${nomineesList[index].voteId.toString()}',
                        style: new TextStyle(
                            fontSize: 11.0, fontWeight: FontWeight.normal)),
                  ]),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new ImageScreen(
                            nomineesList[index].nomineeName,
                            Image.network(
                              nomineesList[index].nomineeImage,
//        fit: BoxFit.fitHeight,
//        width: 100,
                            ))));
              },
            ),
            decoration: selected
                ? new BoxDecoration(
                    color: Colors.grey[300],
                    border: new Border.all(color: Colors.blue))
                : new BoxDecoration(),
          ),
        ));
  }
}
