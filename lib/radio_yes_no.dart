import 'package:flutter/material.dart';

class LikeDisLike extends StatefulWidget {
  @override
  createState() {
    return new CustomRadioState();
  }
}
Color thumpsUp=Colors.grey;
Color thumpsdown=Colors.grey;

class CustomRadioState extends State<LikeDisLike> {
  List<RadioModel> sampleData = new List<RadioModel>();

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
                if(index==0&&thumpsUp==Colors.blueGrey){
                  thumpsUp=Colors.grey;
                  if(thumpsUp==Colors.blueGrey)
                    {
                      thumpsdown=Colors.grey;
                    }

                }
               else if(index==0){
                  thumpsUp=Colors.blueGrey;
                  thumpsdown=Colors.grey;
                }
                if(index==1&&thumpsdown==Colors.blueGrey){
                  thumpsdown=Colors.grey;
                  if(thumpsdown==Colors.blueGrey)
                  {
                    thumpsUp=Colors.grey;
                  }

                }
                else if(index==1){
                  thumpsdown=Colors.blueGrey;
                  thumpsUp=Colors.grey;

                }


              });
            },
            child: new RadioItem(sampleData[index]),
          );
        },
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Container(
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

//              Text(_item.buttonText,
//                  style: new TextStyle(
//                      color:
//                      _item.isSelected ? Colors.white : Colors.black,
//                      //fontWeight: FontWeight.bold,
//                      fontSize: 11.0)),
            ),
//            decoration: new BoxDecoration(
//              color: _item.isSelected
//                  ? Colors.amber[200]
//                  : Colors.transparent,
//              border: new Border.all(
//                  width: 1.0,
//                  color: _item.isSelected
//                      ? Colors.blueAccent
//                      : Colors.grey),
//              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
//            ),
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