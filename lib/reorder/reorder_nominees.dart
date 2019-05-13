import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dragablegridview_flutter/dragablegridviewbin.dart';
import 'package:dragablegridview_flutter/dragablegridview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:random_color/random_color.dart';
import 'package:simple_countdown/simple_countdown.dart';
import 'package:stats/NomineeMasterObject.dart';
import 'package:stats/image_display.dart';

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
    actionTxt='done';
    nomineesList.forEach((heroName) {
      voteBy1==1?
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
        )))):
      voteBy1==2?
      itemBins.add(new ItemBin(Container(
          height: 120,
          width: (widthSize/2)-2,
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                        new ImageScreen('Nominee', Image.network(heroName.nomineeImage))
                    ));
              },
              child: TransitionToImage(
                image: AdvancedNetworkImage(
                  heroName.nomineeImage,
                  loadedCallback: () => print('It works!'),
                  loadFailedCallback: () => print('Oh, no!'),
                  useDiskCache: true,
                  retryDuration: new Duration(seconds: 5),
                  // loadingProgress: (double progress) => print(progress),
                  // disableMemoryCache: true,
                ),
                // loadedCallback: () => print('It works!'),
                // loadFailedCallback: () => print('Oh, no!'),
                // disableMemoryCache: true,
                fit: BoxFit.scaleDown,
                placeholder: Image.asset('images/loader.gif'),
                enableRefresh: true,
                loadingWidgetBuilder: (double progress) {
                  return Container(

                    alignment: Alignment.center,
                    child: Image.asset('images/loader.gif'),
                  );
                },
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(8),
          ),))):Text('');
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      appBar: new AppBar(
        backgroundColor: Colors.white,

        title: new Text("Poll By Re-Ordering",style: TextStyle(fontSize: 12,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
        actions: <Widget>[
          new Center(
              child: new GestureDetector(
                child: new Container(
                  child: actionTxt=='done'? GestureDetector(
      onTap: () {
        setState(() {
          actionTxt='complete';
        });

      },
      child: Row(
        children:  <Widget>[

          Text('Submit Poll  ',style: TextStyle(fontSize: 12,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
          Image.asset('images/submited.png',height: 20,width: 20,),
        ],
      ),
    ):Center(
      child: Countdown(
      seconds: 15,
      onFinish: () {
        setState(() {
          actionTxt='done';

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
            child: itemBins.elementAt(position).data,
          );
        },
        editChangeListener: (){
        //  changeActionState();
          String ddd='sdsd';
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





