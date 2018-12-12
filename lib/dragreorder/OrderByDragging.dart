import 'package:dragablegridview_flutter/dragablegridview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:stats/NomineeMasterObject.dart';

//import 'gridviewitembin.dart';




class OrderByDragging {


  Widget drageableOrder(List<NomineesEntityList> itemBins, int voteBy1) {

    if(voteBy1==1) {
      return DragAbleGridView(
        decoration: new BoxDecoration(
          border: Border.all(color: const Color(0x33A6A6A6)),
          shape: BoxShape.circle,
          image: new DecorationImage(
            image: new AssetImage("images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        itemPadding: EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 5.0),
//        childAspectRatio: 1.8,
        crossAxisCount: 4,
        itemBins: itemBins,
        child: (int position) {
          return new Text(
            itemBins[position].nomineeName,
            style: new TextStyle(fontSize: 14, color: Colors.blue),);
        },
      );
    }
    else if(voteBy1==2){
      return DragAbleGridView(
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(new Radius.circular(3.0)),
          border: new Border.all(color: Colors.blue),
        ),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        itemPadding: EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 5.0),
        childAspectRatio: 1.8,
        crossAxisCount: 4,
        itemBins: itemBins,
        child: (int position) {
          return new Image.network(itemBins[position].nomineeImage);
        },
      );
    }

  }

}