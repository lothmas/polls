import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dragablegridview_flutter/dragablegridviewbin.dart';
import 'package:dragablegridview_flutter/dragablegridview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:simple_countdown/simple_countdown.dart';
import 'package:stats/NomineeMasterObject.dart';

class ItemBin extends DragAbleGridViewBin{

  ItemBin(this.data);

  Widget data;

//  @override
//  Widget toString() {
//    return 'ItemBin{data: $data, dragPointX: $dragPointX, dragPointY: $dragPointY, lastTimePositionX: $lastTimePositionX, lastTimePositionY: $lastTimePositionY, containerKey: $containerKey, containerKeyChild: $containerKeyChild, isLongPress: $isLongPress, dragAble: $dragAble}';
//  }

}





class ReorderNominees extends StatefulWidget{
  List<NomineesEntityList> nomineesList; int voteBy1; double widthSize;
  ReorderNominees(this.nomineesList,this.voteBy1,this.widthSize);

  @override
  State<StatefulWidget> createState() {
    return new DragAbleGridViewDemoState(nomineesList,voteBy1,widthSize);
  }
}

class DragAbleGridViewDemoState extends State<ReorderNominees>{
  List<NomineesEntityList> nomineesList; int voteBy1;
  RandomColor _randomColor = RandomColor();

  List<ItemBin> itemBins=new List();
//  String actionTxtEdit="count down";
//  String actionTxtComplete="Done";
  String actionTxt;
  var editSwitchController=EditSwitchController();
  double widthSize;
  //final List<String> heroes=["鲁班","虞姬","甄姬","黄盖","张飞","关羽","刘备","曹操","赵云","孙策","庄周","廉颇","后裔","妲己","荆轲",];

  DragAbleGridViewDemoState(this.nomineesList,this.voteBy1, this.widthSize);

  @override
  void initState() {

    super.initState();
    actionTxt='Click When Done';
    nomineesList.forEach((heroName) {
      itemBins.add(new ItemBin(Container(
        height: 200,
        width: (widthSize/2)-2,
        child: Center(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                 ListTile(
                  leading: Icon(Icons.album,color: _randomColor.randomColor(),),
                  title: Text(heroName.nomineeName),
                  subtitle: Text(''),
                ),

              ],
            ),
          ),
        ))));
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      appBar: new AppBar(
        backgroundColor: Colors.white,

        title: new Text("Poll By Re-Ordering",style: TextStyle(fontSize: 12,color: Colors.black),),
        actions: <Widget>[
          new Center(
              child: new GestureDetector(
                child: new Container(
                  child: actionTxt=='Click When Done'? Text(actionTxt,style: TextStyle(fontSize: 12.0,color: Colors.black),):Center(
      child: Countdown(
      seconds: 15,
      onFinish: () {
        setState(() {
          actionTxt='completed';

//          CollectionReference collectionReference =
//          Firestore.instance.collection('casted_votes');
//          DocumentReference docReferancew =
//          collectionReference.document();
//          docReferancew.setData({
//            "vote_id": voteID,
//            'member_id': memberID,
//            'vote_number': _radioValue,
//          });
        });
      },
      textStyle: TextStyle(
          fontSize: 14,
          color: Colors.red,
          fontWeight: FontWeight.bold),
    ),
    ),
                  margin: EdgeInsets.only(right: 12),
                ),
                onTap: (){
                 changeActionState();
                  editSwitchController.editStateChanged();
                },
              )
          )
        ],
      ),
      body: new DragAbleGridView(
        mainAxisSpacing:5.0,
        crossAxisSpacing:5.0,
        childAspectRatio:1.8,
        crossAxisCount: 2,
        itemBins:itemBins,
        editSwitchController:editSwitchController,
        /******************************new parameter*********************************/
        isOpenDragAble: true,
        animationDuration: 300, //milliseconds
        longPressDuration: 800, //milliseconds
        /******************************new parameter*********************************/
        deleteIcon: new Image.asset("images/close.png",width: 15.0 ,height: 15.0 ),
        child: (int position){
          return new Container(
//            padding: EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 5.0),
//            decoration: new BoxDecoration(
//              borderRadius: BorderRadius.all(new Radius.circular(3.0)),
//              border: new Border.all(color: Colors.blue),
//            ),
            //因为本布局和删除图标同处于一个Stack内，设置marginTop和marginRight能让图标处于合适的位置
            //Because this layout and the delete_Icon are in the same Stack, setting marginTop and marginRight will make the icon in the proper position.
//            margin: EdgeInsets.only(top: 6.0,right: 6.0),
            child: itemBins.elementAt(position).data,
          );
        },
        editChangeListener: (){
        //  changeActionState();
        },
      ),
    );
  }

  void changeActionState(){
    if(actionTxt=='Click When Done'){
      setState(() {
        actionTxt='count down';
      });
    }
  }
}





