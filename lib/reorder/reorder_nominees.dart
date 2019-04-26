import 'package:flutter/material.dart';

import 'package:reorderables/reorderables.dart';
import 'package:stats/NomineeMasterObject.dart';

class ReorderNominees extends StatefulWidget {
  List<NomineesEntityList> nomineesList;
  ReorderNominees(this.nomineesList, int voteBy1);

  @override
  _WrapExampleState createState() => _WrapExampleState();
}

class _WrapExampleState extends State<ReorderNominees> {
  final double _iconSize = 90;
  List<Widget> _tiles;

  @override
  void initState() {
    super.initState();
    _tiles = <Widget>[
      Container(key: UniqueKey(),
//        height: 200,
//        width: 150,
        child: Card(
          key: UniqueKey(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.album),
                title: Text('The Enchanted Nightingale',style: TextStyle(fontSize: 11),),
                subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.',style: TextStyle(fontSize: 11)),
              ),
              ButtonTheme.bar( // make buttons use the appropriate styles for cards
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('BUY TICKETS'),
                      onPressed: () { /* ... */ },
                    ),
                    FlatButton(
                      child: const Text('LISTEN'),
                      onPressed: () { /* ... */ },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),),
      Container(key: UniqueKey(),
//        height: 200,
//        width: 150,
        child: Card(
          key: UniqueKey(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.album),
                title: Text('The Enchanted Nightingale',style: TextStyle(fontSize: 11),),
                subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.',style: TextStyle(fontSize: 11)),
              ),
              ButtonTheme.bar( // make buttons use the appropriate styles for cards
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('BUY TICKETS'),
                      onPressed: () { /* ... */ },
                    ),
                    FlatButton(
                      child: const Text('LISTEN'),
                      onPressed: () { /* ... */ },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),), Container(key: UniqueKey(),
//        height: 200,
//        width: 150,
        child: Card(
          key: UniqueKey(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.album),
                title: Text('The Enchanted Nightingale',style: TextStyle(fontSize: 11),),
                subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.',style: TextStyle(fontSize: 11)),
              ),
              ButtonTheme.bar( // make buttons use the appropriate styles for cards
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('BUY TICKETS'),
                      onPressed: () { /* ... */ },
                    ),
                    FlatButton(
                      child: const Text('LISTEN'),
                      onPressed: () { /* ... */ },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),),

    ];
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
