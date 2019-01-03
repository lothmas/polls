import 'package:flutter/material.dart';
import 'package:stats/NomineeMasterObject.dart';
import 'package:stats/dropcity/draggable_view.dart';
import 'package:stats/dropcity/draggable_view1.dart';

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
    Widget images=Image.network(
      widget.item.nomineeImage,
      fit: BoxFit.cover,

    height:80.0,
    );
    return new Padding(
        padding: new EdgeInsets.all(0.6),
        child: new LongPressDraggable<NomineesEntityList>(
            onDraggableCanceled: (velocity, offset) {
              setState(() {
                widget.item.selected = false;
                widget.item.status = Status.none;
              });
            },

            childWhenDragging: new DragAvatarBorder(new Text(widget.item.nomineeName),
                color: Colors.white, size: widget.size),
            child: new Card(child: Column(children: <Widget>[

//              new Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
              FadeInImage.assetNetwork(
                placeholder: 'images/loader.gif',
                image:widget.item.nomineeImage,
                fit: BoxFit.cover,
                height:80.0,

              ),
                  new Container(
                      child: new Center(
                          child: new Column(
                            children: <Widget>[
                            //  new SizedBox(height: 0),
                              Text(widget.item.nomineeName,textAlign: TextAlign.center,
                                  style: new TextStyle(color: Colors.black,fontSize: 10.0,
                                      fontWeight: FontWeight.bold))
//                          new Text('Population: ${item.population}')
                            ],
                          )))
            //    ],

],)),
//              elevation: 2.0,
//              margin: EdgeInsets.all(5.0),
         //   ),
            data: widget.item,
            feedback: new DragAvatarBorder1(images,
              new Text(widget.item.nomineeName,
                  style: new TextStyle(
                      fontSize: 12.0,
                      color: Colors.blueGrey,
                      decoration: TextDecoration.none)),
              size: widget.size,
              color: Colors.transparent,
            )));
  }
}
