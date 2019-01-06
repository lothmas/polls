import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:stats/NomineeMasterObject.dart';
import 'package:stats/viewnominies/model/city.dart';
import 'package:stats/image_display.dart';

class DraggableReOrderImage extends StatefulWidget {
  List<NomineesEntityList> nomineesList;
  int voteBy1;

  DraggableReOrderImage(this.nomineesList, this.voteBy1);

  @override
  MyAppState createState() => new MyAppState(nomineesList, voteBy1);
}

class MyAppState extends State<DraggableReOrderImage> {
  List<NomineesEntityList> nomineesList;

  MyAppState(this.nomineesList, this.voteBy1);

  int voteBy1;
  bool validated = false;

  int score = 0;
  Map<int, NomineesEntityList> pairs = {};

  //final List<City> nomineesList = City.allCities();

  @override
  Widget build(BuildContext context) {
    final title = 'Sortable ListView';

    if (voteBy1 == 1) {
      var main= new MaterialApp(
        title: title,
        home: new Scaffold(

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
          body: new SortableListView(
            items: nomineesList,
            itemBuilder: (_, int index) => new Card(
                    child: new Column(
                  children: <Widget>[
                    new ListTile(
                      leading: new Image.asset(
                        nomineesList[index].nomineeImage,
                        fit: BoxFit.fitHeight,
                        width: 100,
                      ),
                      title: new Text(
                        nomineesList[index].nomineeName,
                        style: new TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                      subtitle: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(nomineesList[index].nomineesDescription,
                                style: new TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.normal)),
                            new Text(
                                'Population: ${nomineesList[index].voteId}',
                                style: new TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.normal)),
                          ]),
                      onTap: () {
                        // _showSnackBar(context, nomineesList[index].nomineeName);
                      },
                    )
                  ],
                )),
          ),
        ),
      );
      return banner(main);
    } else if (voteBy1 == 2) {
      var main = new MaterialApp(
        title: title,
        home: new Scaffold(
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
          body: new SortableListView(
            items: nomineesList,
            itemBuilder: (_, int index) => new Card(
                    child: new Column(
                  children: <Widget>[
                    new ListTile(
                      leading: new Container(
                        width: 100.0,
                        height: 68.0,
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


//                        decoration: new BoxDecoration(
//                          image: DecorationImage(
//                            image:
//                                NetworkImage(nomineesList[index].nomineeImage),
//                            fit: BoxFit.fitHeight,
//                          ),
//                        ),
                      ),
                      title: new Text(
                        nomineesList[index].nomineeName,
                        style: new TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                      subtitle: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(nomineesList[index].nomineesDescription,
                                style: new TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.normal)),
                            new Text(
                                'Population: ${nomineesList[index].voteId}',
                                style: new TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.normal)),
                          ]),
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>   new ImageScreen(nomineesList[index].nomineeName,Image.network(nomineesList[index].nomineeImage))
                            ));
                      },
                    )
                  ],
                )),
          ),
        ),
      );
      return banner(main);

    }
  }

  Stack banner(MaterialApp main) {
         return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        main,

        Banner(
          message: "ReOrder",
          location: BannerLocation.topEnd,
        ),


      ],
    );
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


}

_showSnackBar(BuildContext context, City item) {
  final SnackBar objSnackbar = new SnackBar(
    content: new Text("${item.name} is a city in ${item.country}"),
    backgroundColor: Colors.amber,
  );

  Scaffold.of(context).showSnackBar(objSnackbar);
}

class SortableListView extends StatefulWidget {
  final List items;
  final IndexedWidgetBuilder itemBuilder;

  SortableListView({this.items, this.itemBuilder})
      : assert(items != null),
        assert(itemBuilder != null);

  @override
  State createState() => new SortableListViewState();
}

class SortableListViewState extends State<SortableListView> {
  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
      builder: (context, constraint) {
        return new ListView.builder(
          itemCount: widget.items.length + 1,
          addRepaintBoundaries: true,
          itemBuilder: (context, index) {
            return new LongPressDraggable<int>(
              data: index,
              child: new DragTarget<int>(
                onAccept: (int data) {
                  _handleAccept(data, index);
                },
                builder: (BuildContext context, List<int> data,
                    List<dynamic> rejects) {
                  List<Widget> children = [];

                  // If the dragged item is on top of this item, the we draw
                  // a half-visible item to indicate that dropping the dragged
                  // item will add it in this position.
                  if (data.isNotEmpty) {
                    children.add(
                      new Container(
                        decoration: new BoxDecoration(
                          border: new Border.all(
                              color: Colors.grey[600], width: 2.0),
                        ),
                        child: new Opacity(
                          opacity: 0.5,
                          child: _getListItem(context, data[0]),
                        ),
                      ),
                    );
                  }
                  children.add(_getListItem(context, index));

                  return new Column(
                    children: children,
                  );
                },
              ),
              onDragStarted: () {
                Scaffold.of(context).showSnackBar(
                  new SnackBar(
                      content: new Text("Drag Selected Nominee to Change Places")),
                );
              },
              feedback: new Opacity(
                opacity: 0.75,
                child: new SizedBox(
                  width: constraint.maxWidth,
                  child: _getListItem(context, index, true),
                ),
              ),
              childWhenDragging: new Container(),
            );
          },
        );
      },
    );
  }

  void _handleAccept(int data, int index) {
    setState(() {
      // Decrement index so that after removing we'll still insert the item
      // in the correct position.
      if (index > data) {
        index--;
      }
      dynamic imageToMove = widget.items[data];
      widget.items.removeAt(data);
      widget.items.insert(index, imageToMove);
    });
  }

  Widget _getListItem(BuildContext context, int index, [bool dragged = false]) {
    // A little hack: our ListView has an extra invisible trailing item to
    // allow moving the dragged item to the last position.
    if (index == widget.items.length) {
      // This invisible item uses the previous item to determine its size. If
      // the list is empty, though, there's no dragging really.
      if (widget.items.isEmpty) {
        return new Container();
      }
      return new Opacity(
        opacity: 0.0,
        child: _getListItem(context, index - 1),
      );
    }

    return new Material(
      elevation: dragged ? 20.0 : 0.0,
      child: widget.itemBuilder(context, index),
    );
  }
}
