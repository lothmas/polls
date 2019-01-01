import 'package:flutter/material.dart';
import 'package:stats/viewnominies/model/city.dart';


class DraggableReOrderImage extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<DraggableReOrderImage> {
  final List<City> _allCities = City.allCities();

  @override
  Widget build(BuildContext context) {
    final title = 'Sortable ListView';

    return new MaterialApp(
      title: title,
      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text(title),
//        ),
        body: new SortableListView(
          items: _allCities,
          itemBuilder: (_, int index) => new Card(
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    leading: new Image.asset(
                      "images/assets/" + _allCities[index].image,
                      fit: BoxFit.fitHeight,
                      width: 100,
                    ),
                    title: new Text(
                      _allCities[index].name,
                      style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(_allCities[index].country,
                              style: new TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.normal)),
                          new Text('Population: ${_allCities[index].population}',
                              style: new TextStyle(
                                  fontSize: 11.0, fontWeight: FontWeight.normal)),
                        ]),
                    onTap: () {
                      _showSnackBar(context, _allCities[index]);
                    },
                  )
                ],
              )),
        ),
      ),
    );
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
                          content: new Text("Drag the row to change places")),
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
