import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  String voteID, memberID;

  CustomRadio(this.voteID, this.memberID);

  @override
  createState() {
    return new CustomRadioState(voteID, memberID);
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> sampleData = new List<RadioModel>();
  String voteID, memberID;

  CustomRadioState(this.voteID, this.memberID);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sampleData.add(new RadioModel(false, '1'));
    sampleData.add(new RadioModel(false, '2'));
    sampleData.add(new RadioModel(false, '3'));
    sampleData.add(new RadioModel(false, '4'));
    sampleData.add(new RadioModel(false, '5'));
    sampleData.add(new RadioModel(false, '6'));
    sampleData.add(new RadioModel(false, '7'));
    sampleData.add(new RadioModel(false, '8'));
    sampleData.add(new RadioModel(false, '9'));
    sampleData.add(new RadioModel(false, '10'));
    sampleData.add(new RadioModel(false, ''));

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
            color: Colors.transparent,
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('casted_votes')
                  .where('vote_id', isEqualTo: voteID)
                  .where('member_id', isEqualTo: memberID)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                try {
                  if (snapshot.hasData) {
                    sampleData[snapshot.data.documents.elementAt(0)['vote_number']].isSelected = true;
                    return settingNumberRating(snapshot);
                  } else if (snapshot.hasError) {
                    sampleData[11].isSelected = true;
                  }
                  sampleData[11].isSelected = true;
                } catch (e) {
                  sampleData[10].isSelected = false;
                  return settingNumberRating(snapshot);

                }
              },
            )));
  }

  Container settingNumberRating(AsyncSnapshot<QuerySnapshot> snapshot) {

    return Container (child: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[

        new Expanded(child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: sampleData.length,
          itemBuilder: (BuildContext context, int index) {
            return new InkWell(
              //highlightColor: Colors.red,
              splashColor: Colors.blueAccent,
              onTap: () {
                setState(() {
                  sampleData.forEach(
                          (element) => element.isSelected = false);
                  sampleData[index].isSelected = true;
                });
              },
              child: new RadioItem(sampleData[index]),
            );
          },
        ))

      ],)
    );




    return
      new Container(
          height: 500.0,
          child: new ListView.builder(

          scrollDirection: Axis.horizontal,
      itemCount: sampleData.length,
      itemBuilder: (BuildContext context, int index) {
        return new InkWell(
          //highlightColor: Colors.red,
          splashColor: Colors.blueAccent,
          onTap: () {
            setState(() {
              sampleData.forEach(
                  (element) => element.isSelected = false);
              sampleData[index].isSelected = true;
            });
          },
          child: new RadioItem(sampleData[index]),
        );
      },
    ),
//          Row(
//            //  crossAxisAlignment: CrossAxisAlignment.b,
//            mainAxisAlignment: MainAxisAlignment.end,
//            children: <Widget>[
//              Text('🗳 polls: ️',
//                style: TextStyle(color: Colors.black,fontSize: 11),),
//              Container(
//                  color: Colors.white,
//                  child: StreamBuilder<QuerySnapshot>(
//                    stream: Firestore.instance
//                        .collection('casted_votes')
//                        .where('vote_id', isEqualTo: voteID)
//                        .snapshots(),
//                    builder:
//                        (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                      try {
//                        if (snapshot.hasData) {
//                          return Text(snapshot.data.documents.length.toString(),style: TextStyle(fontSize: 11),);
//                        } else if (snapshot.hasError) {}
//                      } catch (e) {
//                      }
//                    },
//                  )),
//              Text('  ')
//            ],
//          ),
          );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return new Container(
//      margin: new EdgeInsets.all(1.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Container(
            height: 35.0,
            width: 35.0,
            child: new Center(
              child: new Text(_item.buttonText,
                  style: new TextStyle(
                      color: _item.isSelected ? Colors.white : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 11.0)),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected ? Colors.amber : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color:
                  _item.buttonText!=''? Colors.transparent :_item.isSelected ? Colors.blueAccent : Colors.blueGrey),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
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
