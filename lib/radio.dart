import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:simple_countdown/simple_countdown.dart';
import 'package:sqflite/sqflite.dart';

class YesNoMaybe extends StatefulWidget {
  String voteID, memberID;

  YesNoMaybe(this.voteID, this.memberID);

  @override
  State<StatefulWidget> createState() {
    return new _CurrencyState(voteID, memberID);
  }
}

class _CurrencyState extends State<YesNoMaybe> {
  final TextEditingController _currencyController = new TextEditingController();
  int _radioValue;

  String voteID, memberID;
  int castedVoteNumber;

  static const EURO_MUL = 0.86;
  static const POUND_MUL = 0.75;
  static const YEN_MUL = 110.63;
  double _result = 0.0;
  String _textResult = '';

  _CurrencyState(String voteID, String memberID) {
    this.voteID = voteID;
    this.memberID = memberID;
    Firestore.instance
        .collection("casted_votes")
        .where("member_id", isEqualTo: memberID)
        .where("vote_id", isEqualTo: voteID)
        .getDocuments()
        .then((string) {
      if (string.documents.length != 0) {
        setState(() {
          _radioValue = string.documents.elementAt(0)['vote_number'];
          castedVoteNumber=1;
        });
      } else {
        setState(() {
          _radioValue = 3;
          castedVoteNumber=0;
        });
      }
    });
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      if(_radioValue!=3&& castedVoteNumber==1){
       // _showSnackBar(context,"maximum votes for this poll have already been reached.");
      }
      else{
        _radioValue = value;
      }
    });
  }

  String popularRating='';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: new Container(
          alignment: Alignment.center,
          child: new ListView(
//            padding: const EdgeInsets.all(25.0),
            children: <Widget>[
              new Container(
//                margin: const EdgeInsets.all(3.0),
                alignment: Alignment.center,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
//                    new Padding(padding: new EdgeInsets.all(5.0)),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            new Radio(
                              activeColor: Colors.amber,
                              value: 1,
                              groupValue: _radioValue,
                              onChanged: _handleRadioValueChange,
                            ),
                            new Text(
                              'NO',
                              style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            new Radio(
                              activeColor: Colors.amber,
                              value: 0,
                              groupValue: _radioValue,
                              onChanged: _handleRadioValueChange,
                            ),
                            new Text(
                              'YES',
                              style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            new Radio(
                              activeColor: Colors.amber,
                              value: 2,
                              groupValue: _radioValue,
                              onChanged: _handleRadioValueChange,
                            ),
                            new Text(
                              'MAYBE',
                              style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                    castedVoteNumber == 0 && _radioValue != 3
                        ? Row(
                      //  crossAxisAlignment: CrossAxisAlignment.b,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('poll lock-down in:  ',
                            style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold,fontSize: 11)),
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
                                  'vote_number': _radioValue,
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
                    )
                        : Text(''),
//                    Container(
//                      height: 10,
//                      color: Colors.transparent,
//                    ),
                    Row(
                      //  crossAxisAlignment: CrossAxisAlignment.b,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: <Widget>[     Text(
                            '🔥 popular rate: ️'+popularRating,
                            style: TextStyle(color: Colors.black, fontSize: 11),
                          ),
                          ],),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,

                          children: <Widget>[     Text(
                            '🗳 total polls: ️',
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
                                      _getPopular(snapshot.data.documents,voteID);
                                      return Text(snapshot.data.documents.length.toString(),style: TextStyle(fontSize: 11),);
                                    } else if (snapshot.hasError) {
                                      return Text('0');
                                    }
                                  } catch (e) {
                                    return Text('0');
                                  }
                                },
                              )),Text('  ')],)
                      ],
                    ),

                  ],
                ),
              )
            ],
          )),
    );
  }

  _getPopular(List<DocumentSnapshot> documents ,String voteID) async {
    String voteIDRefactored=voteID.replaceAll('-', '');

    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, voteIDRefactored);
    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE '+voteIDRefactored+' (popular TEXT)');
        });


    for (DocumentSnapshot query in documents) {
      // Insert some records in a transaction
      String insertQuery='INSERT INTO '+voteIDRefactored+'(popular) VALUES('+query['vote_number'].toString()+')';
      await database.transaction((txn) async {
        await txn.rawInsert(insertQuery);
      });
    }
    String popularRate='SELECT `popular` FROM `'+voteIDRefactored+'` GROUP BY `popular` ORDER BY COUNT(*) DESC LIMIT 1;';

    await database.transaction((txn) async {
      var count= await txn.rawQuery(popularRate);

      setState(() {
        popularRating= count.elementAt(0)['popular'].toString();
      });
    });

// Close the database
    await database.close();
  }

  /// This will show snackbar at bottom when user tap on Grid item
  _showSnackBar(BuildContext context, String item) {
    final SnackBar objSnackbar = new SnackBar(
      content: new Text(item,style: TextStyle(fontSize: 11),),
      backgroundColor: Colors.blueGrey,
    );

    Scaffold.of(context).showSnackBar(objSnackbar);
  }

  double _currencyCalculate(String amount, double multiplier) {
    double _amount = amount.isNotEmpty ? double.parse(amount) : 0.0;

    if (_amount.toString().isNotEmpty && _amount > 0) {
      return _amount * multiplier;
    } else {
      return -1.0;
    }
  }
}
