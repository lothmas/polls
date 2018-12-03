import 'package:flutter/material.dart';
import 'package:stats/NomineeMasterObject.dart';
import 'package:stats/dropcity/country.dart';
import 'package:stats/dropcity/draggable_view.dart';

typedef void DropItemSelector(Country item, DropTarget target);

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
                width: widget.size.width,
                height: widget.size.height,
                decoration: new BoxDecoration(
                    color:
                         Colors.cyan[100],
                    border: new Border.all(
                        width: 2.0,
                        color:
                            accepted.isEmpty ? Colors.grey : Colors.cyan[300])),
                child: widget.selection != null
                    ? new Column(children: [
                        new Padding(
                            padding: new EdgeInsets.symmetric(vertical: 16.0),
                            child: new Text(widget.item.nomineesDescription)),
                        new Center(
                            child: new SizedBox(
                                width: widget.itemSize.width,
                                height: widget.itemSize.height,
                                child: new Material(
                                    elevation: 1.0,
                                    child: new Center(
                                      child: new Text(
                                        widget.selection.nomineeName,
                                      ),
                                    )))),
                      ])
                    : new Center(child: new Text(widget.item.nomineesDescription))));
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
