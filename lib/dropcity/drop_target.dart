import 'package:flutter/material.dart';
import 'package:simple_countdown/simple_countdown.dart';
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

  DropTarget(this.item,
      {this.size, NomineesEntityList selectedItem, this.itemSize}) {
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
              width: MediaQuery.of(context).size.width - 8,
              height: 110,
              decoration: new BoxDecoration(
                color: accepted.isEmpty
                    ? (widget.selection != null
                        ? getDropBorderColor(widget.selection.status)
                        : Colors.transparent)
                    : Colors.lime[200],
                border: Border(
                    bottom: BorderSide(color: Theme.of(context).dividerColor),
//                      left: BorderSide(color: Theme.of(context).dividerColor),
                    top: BorderSide(color: Theme.of(context).dividerColor)),
//                    border: new Border.all(
//                        width: 1.0,
//                        color:
//                            accepted.isEmpty ? Colors.lightBlueAccent : Colors.cyan[200])
              ),
              child: widget.selection != null
                  ? new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                          new Center(
                              child: new SizedBox(
//                              width: MediaQuery.of(context).size.width,
                                  child: new Material(
                                      child: new Center(
                            child: new Image.network(
                              widget.selection.nomineeImage,
                              height: 100,
                            ),
                          )))),
                          new Countdown(
                            seconds: 15,
                            onFinish: () {
                              setState(() {});
                            },
                            textStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                        ])
                  : new Center(
                      child: new Text(widget.item.nomineesDescription,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                          )))),
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
                fontSize: 12.0,
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold)),
        size: widget.itemSize,
        color: Colors.cyan,
      ));
}
