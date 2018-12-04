import 'package:flutter/material.dart';
import 'package:stats/NomineeMasterObject.dart';
import 'package:stats/dropcity/draggable_view.dart';

typedef void DropItemSelector(NomineesEntityList item, DropTarget target);

class SelectionNotification extends Notification {
  final int dropIndex;
  final NomineesEntityList item;
  final bool cancel;

  SelectionNotification(this.dropIndex, this.item, {this.cancel: false});
}

class DropTarget extends StatefulWidget {
  final NomineesEntityList item;

  final Size size;
  final Size itemSize;

  NomineesEntityList _selection;

  NomineesEntityList get selection => _selection;

  get id => item.id;

  set selection(NomineesEntityList value) {
    clearSelection();
    _selection = value;
  }

  DropTarget(this.item, {this.size, NomineesEntityList selectedItem, this.itemSize}) {
    _selection = selectedItem;
  }
  @override
  _DropTargetState createState() => new _DropTargetState();

  void clearSelection() {
    if (_selection != null) _selection.selected = false;
  }
}

class _DropTargetState extends State<DropTarget> {
  static const double kFingerSize = 50.0;

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: new EdgeInsets.all(4.0),
        child:
            widget.selection != null ? addDraggable(getTarget()) : getTarget());
  }

  Widget addDraggable(DragTarget target) => new Draggable<NomineesEntityList>(
      data: widget.selection,
      dragAnchor: DragAnchor.pointer,
      onDraggableCanceled: onDragCancelled,
      feedback: getCenteredAvatar(),
      child: target);

  DragTarget getTarget() => new DragTarget<NomineesEntityList>(
      onWillAccept: (item) => widget.selection != item,
      onAccept: (value) {
        new SelectionNotification(widget.item.id, value).dispatch(context);
      },
      builder: (BuildContext context, List<NomineesEntityList> accepted,
          List<dynamic> rejected) {
        return new SizedBox(
            child: new Container(
                width: 270,
                height: 120,
                decoration: new BoxDecoration(
                    color: accepted.isEmpty
                        ? (widget.selection != null
                            ? getDropBorderColor(widget.selection.status)
                            : Colors.grey[300])
                        : Colors.cyan[100],
                    border: new Border.all(
                        width: 1.0,
                        color:
                            accepted.isEmpty ? Colors.lightBlueAccent : Colors.cyan[600])),
                child: widget.selection != null
                    ? new Column(children: [
                        new Padding(
                            padding: new EdgeInsets.symmetric(vertical: 12.0),
                            child: new Text(widget.item.nomineesDescription,style:TextStyle(fontWeight: FontWeight.bold),)),
                        new Center(
                            child: new SizedBox(
                                width: 240,
                                height: 70,
                                child: new Material(
                                    elevation: 10.0,
                                    child: new Center(
                                      child: new
                                      Text(
                                        widget.selection.nomineeName,
                                        textAlign: TextAlign.center,
                                        style:  TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold),
                                      ),

                                    )))),
                      ])
                    : new Center(child: new Text(widget.item.nomineesDescription))),


        );
      });

  void onDragCancelled(Velocity velocity, Offset offset) {
    setState(() {
      widget.selection = null;
      new SelectionNotification(widget.item.id, widget.selection, cancel: true)
          .dispatch(context);
    });
  }

  Widget getCenteredAvatar() => new Transform(
      transform: new Matrix4.identity()
        ..translate(-100.0 / 2.0, -(100.0 / 2.0)),
      child: new DragAvatarBorder(
        new Text(widget.selection?.nomineeName,
            style: new TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                decoration: TextDecoration.none)),
        size: widget.itemSize,
        color: Colors.cyan,
      ));
}
