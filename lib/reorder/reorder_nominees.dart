import 'package:flutter/material.dart';

import 'package:reorderables/reorderables.dart';
import 'package:stats/NomineeMasterObject.dart';

class ReorderNominees extends StatefulWidget {
  List<NomineesEntityList> nomineesList;
  List<Widget> _tiles =new List();

  ReorderNominees(this.nomineesList, int voteBy1){
    try {
      for (NomineesEntityList nominee in nomineesList) {
        _tiles.add(Container(
          key: UniqueKey(),
//        height: 200,
//        width: 150,
          child: Card(
            key: UniqueKey(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                 ListTile(
                  leading: Icon(Icons.album),
                  title: Text(nominee.nomineeName),
                  subtitle: Text(
                      'Music by Julie Gable. Lyrics by Sidney Stein.',
                      style: TextStyle(fontSize: 11)),
                ),
                ButtonTheme
                    .bar( // make buttons use the appropriate styles for cards
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child:  Text('votes: 23'),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                      FlatButton(
                        child:  Text('LISTEN'),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),),);
      }
    }catch(e){

    }
  }

  @override
  _WrapExampleState createState() => _WrapExampleState(_tiles);
}

class _WrapExampleState extends State<ReorderNominees> {
  List<Widget> _tiles;

  _WrapExampleState(this._tiles);


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        Widget row = _tiles.removeAt(oldIndex);
        _tiles.insert(newIndex, row);
      });
    }

    return ReorderableWrap(
        spacing: 8.0,
        runSpacing: 1.0,
        padding: const EdgeInsets.all(8),
        children: _tiles,
        onReorder: _onReorder
    );
  }
}
