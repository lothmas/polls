import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stats/dropcity/draggable_view.dart';
enum Status { none, correct, wrong }

class DraggableCity extends StatefulWidget {




  final DocumentSnapshot  item;
  final Size size;

  bool enabled = true;
  DraggableCity(this.item, {this.size});

  bool _selected = false;

  bool get selected => _selected;

  void set selected(bool value) {
    _selected = value;
    if( _selected == false )
      status = Status.none;
  }
  Status status;


  @override
  _DraggableCityState createState() => new _DraggableCityState();
}

class _DraggableCityState extends State<DraggableCity> {
  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: new EdgeInsets.all(2.0),
        child: new LongPressDraggable<DocumentSnapshot>(
            onDraggableCanceled: (velocity, offset) {
              setState(() {
//                widget.item.selected = false;
     //           widget.item.status = Colors.transparent;
              });
            },
            childWhenDragging: new DragAvatarBorder(new Text(widget.item['nominee_name']),
                color: Colors.white, size: widget.size),
            child: new  Container(
        decoration: new BoxDecoration(
        image: new DecorationImage(
        image: new AssetImage("images/background.jpg"),
      fit: BoxFit.cover,
    ),
    ),
                child: new Center(
                  child: new Text(widget.item['nominee_name'],textAlign: TextAlign.center,
                      style: new TextStyle(color: Colors.black,fontSize: 14.0,
                          fontWeight: FontWeight.bold)),
                )),
            data: widget.item,
            feedback: new DragAvatarBorder(
              new Text(widget.item['nominee_name'],
                  style: new TextStyle(
                      fontSize: 16.0,
                      color: Colors.blueGrey,
                      decoration: TextDecoration.none)),
              size: widget.size,
              color: Colors.transparent,
            )));
  }
}
