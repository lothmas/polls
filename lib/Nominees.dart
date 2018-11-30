import 'package:flutter/material.dart';
import 'package:stats/NomineeMasterObject.dart';
import 'package:stats/Polling.dart';
import 'package:stats/TrendingMasterObject.dart';
import 'package:badge/badge.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:quiver/async.dart';
import 'package:super_tooltip/super_tooltip.dart';

class Nominees {
  List<Widget> nominees(List<NomineesEntityList> nomineesEntityList) {
    Color caughtColor = Colors.grey;

    List<Widget> list = new List();
    int count = 1;
    for (NomineesEntityList nomineeList in nomineesEntityList) {
      list.add(DragBox(Offset(100.0 * count, 0.0), nomineeList.nomineeImage,
          Colors.greenAccent));
      count++;
    }
    list.add(Positioned(
      left: 100.0,
      bottom: 0.0,
      child: DragTarget(
        onAccept: (Color color) {
          caughtColor = color;
        },
        builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          return Container(
            width: 200.0,
            height: 200.0,
            decoration: BoxDecoration(
              color: accepted.isEmpty ? caughtColor : Colors.grey.shade200,
            ),
            child: Center(
              child: Text("Drag Here!"),
            ),
          );
        },
      ),
    ));

    return list;
  }
}

class DragBox extends StatefulWidget {
  final Offset initPos;
  final String label;
  final Color itemColor;

  DragBox(this.initPos, this.label, this.itemColor);

  @override
  DragBoxState createState() => DragBoxState();
}

class DragBoxState extends State<DragBox> {
  Offset position = Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: position.dx,
        top: position.dy,
        child: Draggable(
          data: widget.itemColor,
          child: Container(
            width: 100.0,
            height: 100.0,
            color: widget.itemColor,
            child: Center(
                child: Image(image: NetworkImage(widget.label),width: 100,height: 100,fit: BoxFit.fill,alignment: Alignment.center,),

            ),
          ),
          onDraggableCanceled: (velocity, offset) {
            setState(() {
              position = offset;
            });
          },
          feedback: Container(
            width: 120.0,
            height: 120.0,
            color: widget.itemColor.withOpacity(0.5),
            child: Center(
              child: Image(image: NetworkImage(widget.label),width: 18,height: 18,fit: BoxFit.fill,alignment: Alignment.center,)
            ),
          ),
        ));
  }
}
