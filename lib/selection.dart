import 'package:flutter/material.dart';
import 'package:stats/NomineeMasterObject.dart';
import 'package:stats/gridview_selection.dart';
//import 'package:selectable_gridview/gridview_item.dart';

//void main() => runApp(PollBySelect());

class PollBySelect extends StatelessWidget {
  List<NomineesEntityList> nomineesList; int voteBy1;
  PollBySelect(this.nomineesList,this.voteBy1);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Poll By Single Selextion',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: HomePage(nomineesList,voteBy1),
    );
  }
}

class HomePage extends StatefulWidget {
  List<NomineesEntityList> nomineesList; int voteBy1;
  HomePage(this.nomineesList,this.voteBy1, {Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(nomineesList,voteBy1);
}

class _HomePageState extends State<HomePage> {
  List<NomineesEntityList> _icons; int voteBy1;

  List<NomineesEntityList> _selectedIcons = [];

  _HomePageState(this._icons,this.voteBy1);

  @override
  Widget build(BuildContext context) {
    Widget gridViewSelection = GridView.count(
      childAspectRatio: 2.0,
      crossAxisCount: 2,
      mainAxisSpacing: 4.0,
      padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
      children: _icons.map((nominee) {
        return GestureDetector(
          onTap: () {
            _selectedIcons.clear();

            setState(() {
              _selectedIcons.add(nominee);
            });
          },
          child: GridViewItem(Image.network(nominee.nomineeImage), _selectedIcons.contains(nominee)),
        );
      }).toList(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Selectable GridView'),
      ),
      body: gridViewSelection,
    );
  }
}