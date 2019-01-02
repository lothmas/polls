import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class DragAvatarBorder1 extends StatelessWidget {

  final Color color;
  final double scale;
  final double opacity;
  final Widget child;
  final Size size;
  final Widget image;
  DragAvatarBorder1(this.child, this.image,
    {this.color, this.scale: 1.0, this.opacity: 1.0, @required this.size});

  @override
  Widget build(BuildContext context)  =>
    new Opacity(
      opacity: opacity,
      child: new Container(
        decoration: new BoxDecoration(
          border: Border.all(color: Colors.transparent),
          shape: BoxShape.circle,
//                  image: new DecorationImage(
//                    image: new AssetImage("images/background.jpg"),
//                    fit: BoxFit.cover,
//                  ),
        ),
        transform: new Matrix4.identity()..scale(scale),
        width: size.width,
        height: size.height,
//        color: color ?? Colors.transparent,
        child: new Center(child: Column(children: <Widget>[child,image],)),
      ));
}