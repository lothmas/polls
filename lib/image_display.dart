import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageScreen extends StatelessWidget {
  String title;
  Image image;
  ImageScreen(this.title,this.image);

  @override
  Widget build(BuildContext context) {
   return new MaterialApp(

       home:
    new Scaffold(
//                    backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 2,
        title: new Text(
          title,
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.black,fontSize: 11),
        ),
        leading: GestureDetector(
            child: Image(
              image: new AssetImage("images/exit.png"),
              width: 14,
              height: 14,
              color: null,
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
            ),
            onTap: () {
              Navigator.pop(
                  context);
            }),
      ),
      body: SafeArea(child:
      Container(
        child: PhotoView(
            imageProvider:image.image),
      )
      ),


    ));
  }

}
