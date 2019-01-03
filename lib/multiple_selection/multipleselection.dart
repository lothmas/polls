import 'package:flutter/material.dart';
import 'package:stats/NomineeMasterObject.dart';
import 'package:stats/image_display.dart';
import 'package:stats/viewnominies/model/city.dart';

//void main() => runApp(new MyApp());
List<NomineesEntityList> nomineesList = new List();
int voteBy;
class MultipleSelection1 extends StatelessWidget {
  MultipleSelection1(List<NomineesEntityList> nomineesList1,int voteBy1){
    nomineesList=nomineesList1;
    voteBy=voteBy1;
  }

  @override
  Widget build(BuildContext context) {
    return  new MyHomePage();
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

    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text('Selected ${indexList.length}  ' + indexList.toString()),
//      ),
      body: new ListView.builder(
        itemCount: nomineesList.length,
        itemBuilder: (context, index,) {
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
//      floatingActionButton: new FloatingActionButton(
//        onPressed: () {},
//        tooltip: 'Increment',
//        child: new Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CustomWidget extends StatefulWidget {
  final int index;
  final bool longPressEnabled;
  final VoidCallback callback;

  const CustomWidget({Key key, this.index, this.longPressEnabled, this.callback}) : super(key: key);

  @override
  _CustomWidgetState createState() => new _CustomWidgetState(index);
}

class _CustomWidgetState extends State<CustomWidget> {

  bool selected = false;
  int index;
  _CustomWidgetState(this.index);

  @override
  Widget build(BuildContext context) {
    var image;
    if(voteBy==1){
      image= new AssetImage(
        "images/nominee_images/nominee" + index.toString()+".jpg",

      );

    }
    else if(voteBy==2) {
      image= new NetworkImage(
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
      child: Card(child:  new Container(
        margin: new EdgeInsets.all(5.0),
        child: new ListTile(
          leading:  (new Container(
          width: 100.0,
          height: 79.0,
          alignment: Alignment.center,
              foregroundDecoration: new BoxDecoration(
                  color: Color.fromRGBO(155, 85, 250, 0.0)),
              child: FadeInImage.assetNetwork(
                placeholder: 'images/loader.gif',
                image:nomineesList[index].nomineeImage,
                width: 100.0,
                height: 79.0,
                fit: BoxFit.fill,
              )
        )),
          title: new Text(
            nomineesList[index].nomineeName,
            style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          subtitle: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(nomineesList[index].nomineeName,
                    style: new TextStyle(
                        fontSize: 13.0, fontWeight: FontWeight.normal)),
                new Text('Population: ${nomineesList[index].voteId.toString()}',
                    style: new TextStyle(
                        fontSize: 11.0, fontWeight: FontWeight.normal)),
              ]),
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>   new ImageScreen(nomineesList[index].nomineeName,Image.network(
                      nomineesList[index].nomineeImage,
//        fit: BoxFit.fitHeight,
//        width: 100,
                    ))
                ));          },
        ),
        decoration: selected
            ? new BoxDecoration(color: Colors.grey[300], border: new Border.all(color: Colors.blue))
            : new BoxDecoration(),
      ),)
    );
  }
}