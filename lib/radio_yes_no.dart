import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_countdown/simple_countdown.dart';

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
int castedVoteNumber =1;
int voteNumber=3;
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

      body:

      new Column(
        children: <Widget>[
          new Expanded(
            child: new ListView.builder(
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
                      voteNumber=index+1;
                      if(castedVoteNumber==1){
                        _showSnackBar(context,"maximun vote for this poll has already been reached.");
                      }
                      else {
                        if (index == 0 && thumpsUp == Colors.orangeAccent) {
                          thumpsUp = Colors.grey;
                          if (thumpsUp == Colors.orangeAccent) {
                            thumpsdown = Colors.grey;
                          }
                        }
                        else if (index == 0) {
                          thumpsUp = Colors.orangeAccent;
                          thumpsdown = Colors.grey;
                        }
                        if (index == 1 && thumpsdown == Colors.orangeAccent) {
                          thumpsdown = Colors.grey;
                          if (thumpsdown == Colors.orangeAccent) {
                            thumpsUp = Colors.grey;
                          }
                        }
                        else if (index == 1) {
                          thumpsdown = Colors.orangeAccent;
                          thumpsUp = Colors.grey;
                        }
                      }
                    });
                  },
                  child:  new RadioItem(sampleData[index],voteID,memberID),
                );
              },
            ),
          ),
          castedVoteNumber == 0 && voteNumber != 3
              ? Row(
            //  crossAxisAlignment: CrossAxisAlignment.b,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('poll lock-in countdown:  ',
                  style: TextStyle(color: Colors.blueGrey)),
              Center(
                child: Countdown(
                  seconds: 15,
                  onFinish: () {
                    setState(() {
                      castedVoteNumber = 1;
                      CollectionReference collectionReference =
                      Firestore.instance.collection('casted_votes');
                      DocumentReference docReferancew =
                      collectionReference.document();
                      docReferancew.setData({
                        "vote_id": voteID,
                        'member_id': memberID,
                        'vote_number': voteNumber,
                      });
                    });
                  },
                  textStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ):Text(''),
          Row(
            //  crossAxisAlignment: CrossAxisAlignment.b,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                '🗳 polls: ️',
                style: TextStyle(color: Colors.black, fontSize: 11),
              ),
              Container(
                  color: Colors.white,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection('casted_votes')
                        .where('vote_id', isEqualTo: voteID)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      try {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data.documents.length.toString(),
                            style: TextStyle(fontSize: 11),
                          );
                        } else if (snapshot.hasError) {}
                      } catch (e) {}
                    },
                  )),
              Text('  ')
            ],
          ),
        ],
      )


    );
  }

  /// This will show snackbar at bottom when user tap on Grid item
  _showSnackBar(BuildContext context, String item) {
    final SnackBar objSnackbar = new SnackBar(
      content: new Text(item),
      backgroundColor: Colors.amber,
    );

    Scaffold.of(context).showSnackBar(objSnackbar);
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
                try {
                  if (snapshot.hasData) {
                   int snapshots= snapshot.data.documents.elementAt(0)['vote_number'];
                   castedVoteNumber=1;
                   return show(snapshots);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Text("");
                }
                catch(e){
                  castedVoteNumber=0;

                  return show(0);

                }
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

  Container show(int snapshot) {

    return  snapshot==1?
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
      snapshot==2?
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
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;


  RadioModel(this.isSelected, this.buttonText);
}