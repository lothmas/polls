import 'package:flutter/material.dart';
import 'package:stats/NomineeMasterObject.dart';
import 'package:stats/dropcity/draggable_view.dart';

class DraggableImages extends StatefulWidget {
  final NomineesEntityList item;
  final Size size;

  bool enabled = true;
  DraggableImages(this.item, {this.size});

  @override
  _DraggableImages createState() => new _DraggableImages();
}

class _DraggableImages extends State<DraggableImages> {
  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: new EdgeInsets.all(2.0),
        child: new LongPressDraggable<NomineesEntityList>(
            onDraggableCanceled: (velocity, offset) {
              setState(() {
                widget.item.selected = false;
                widget.item.status = Status.none;
              });
            },
            childWhenDragging: new DragAvatarBorder(new Text(widget.item.nomineeName),
                color: Colors.white, size: widget.size),
            child: new  Container(
                decoration: new BoxDecoration(
                  border: Border.all(color: const Color(0x33A6A6A6)),
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    image:  NetworkImage(widget.item.nomineeImage
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: new Center(
                  child: new Text(widget.item.nomineeName,textAlign: TextAlign.center,
                      style: new TextStyle(color: Colors.black,fontSize: 14.0,
                          fontWeight: FontWeight.bold)),
                )),
            data: widget.item,
            feedback: new DragAvatarBorder(
              new Text(widget.item.nomineeName,
                  style: new TextStyle(
                      fontSize: 16.0,
                      color: Colors.blueGrey,
                      decoration: TextDecoration.none)),
              size: widget.size,
              color: Colors.transparent,
            )));
  }
}
