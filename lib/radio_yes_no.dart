import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LikeDisLike extends StatefulWidget {
  String voteID,memberID;
  LikeDisLike(this.voteID,this.memberID);

  @override
  createState() {
    return new CustomRadioState(voteID,memberID);
  }
}
Color thumpsUp=Colors.grey;
Color thumpsdown=Colors.grey;

class CustomRadioState extends State<LikeDisLike> {
  List<RadioModel> sampleData = new List<RadioModel>();
  String voteID,memberID;
  CustomRadioState(this.voteID,this.memberID);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sampleData.add(new RadioModel(false, 'Like'));
    sampleData.add(new RadioModel(false, 'DisLike'));

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,

      body: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sampleData.length,
        itemBuilder: (BuildContext context, int index) {
          return new InkWell(
            //highlightColor: Colors.red,
            splashColor: Colors.blueAccent,
            onTap: () {
              setState(() {
                sampleData.forEach((element) => element.isSelected = false);
                sampleData[index].isSelected = true;


                if(index==0&&thumpsUp==Colors.orangeAccent){
                  thumpsUp=Colors.grey;
                  if(thumpsUp==Colors.orangeAccent)
                    {
                      thumpsdown=Colors.grey;
                    }

                }
               else if(index==0){
                  thumpsUp=Colors.orangeAccent;
                  thumpsdown=Colors.grey;
                }
                if(index==1&&thumpsdown==Colors.orangeAccent){
                  thumpsdown=Colors.grey;
                  if(thumpsdown==Colors.orangeAccent)
                  {
                    thumpsUp=Colors.grey;
                  }

                }
                else if(index==1){
                  thumpsdown=Colors.orangeAccent;
                  thumpsUp=Colors.grey;

                }


              });
            },
            child: new RadioItem(sampleData[index],voteID,memberID),
          );
        },
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  String voteID,memberID;

  RadioItem(this._item, this.voteID, this.memberID);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              color: Colors.transparent,
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('casted_votes')
                    .where('vote_id', isEqualTo: voteID)
                    .where('member_id', isEqualTo: memberID)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                  if (snapshot.hasData) {
                 return  snapshot.data.documents.elementAt(0)['vote_number']==1?
                   Container(
                     height: 35.0,
                     width: 35.0,
                     child: new Center(
                         child:  _item.buttonText=="Like"?
                         Column(children: <Widget>[new Icon(
                           Icons.thumb_up,
                           color:Colors.orangeAccent,
                         ),Text("like",style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),)],):Column(children: <Widget>[new Icon(
                           Icons.thumb_down,
                           color: thumpsdown,
                         ),Text("dis-like",style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),)],)

                     ),):
                   snapshot.data.documents.elementAt(0)['vote_number']==2?
                   Container(
                      height: 35.0,
                      width: 35.0,
                      child: new Center(
                          child:  _item.buttonText=="Like"?
                          Column(children: <Widget>[new Icon(
                            Icons.thumb_up,
                            color:thumpsUp,
                          ),Text("like",style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),)],):Column(children: <Widget>[new Icon(
                            Icons.thumb_down,
                            color:Colors.orangeAccent,
                          ),Text("dis-like",style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),)],)

                      ),):
                   Container(
                     height: 35.0,
                     width: 35.0,
                     child: new Center(
                         child:  _item.buttonText=="Like"?
                         Column(children: <Widget>[new Icon(
                           Icons.thumb_up,
                           color:thumpsUp,
                         ),Text("like",style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),)],):Column(children: <Widget>[new Icon(
                           Icons.thumb_down,
                           color: thumpsdown,
                         ),Text("dis-like",style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),)],)

                     ),)

                   ;
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Text("");

                },
              )),

//          new Container(
//            margin: new EdgeInsets.only(left: 10.0),
//            child: new Text(_item.text),
//          )
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;


  RadioModel(this.isSelected, this.buttonText);
}