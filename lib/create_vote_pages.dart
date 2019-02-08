import 'package:flutter/material.dart';
import 'package:stats/MultiplePages.dart';
import 'package:stats/age_range.dart';
import 'package:stats/page1.dart';
import 'package:stats/tag.dart';
import 'package:stats/tag1.dart';
import 'package:stats/text_focus_helper.dart';
import 'package:stats/vote_by_dropdown.dart';

class Test extends StatefulWidget {

  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  FocusNode _focusNodeFirstName = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return MultiPageForm(
      totalPage: 3,
      pageList: <Widget>[page1(), page2(), VoteNeededData()],
      onFormSubmitted: () {
        print("Form is submitted");
      },
    );
  }
  Widget page1() {
   return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[

                new Opacity(
                    opacity: 1.0,
                    child: new Container(
                      decoration: new BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                        shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    image: new AssetImage("images/background.jpg"),
                    fit: BoxFit.cover,
                  ),
                      ),
                      transform: new Matrix4.identity()..scale(1.0),
//                      width: size.width,
//                      height: size.height,
//        color: color ?? Colors.transparent,
                      child: Page1(),
                    ))



            ],
            ),
          ),
        );
      },
    );
  }

  Widget page2() {

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                //
        new ListTile(
     //     leading: const Icon(Icons.cloud_upload),
          title: const Text('Upload Poll Image / Video',style:  TextStyle( color: Colors.white70, fontSize: 8.0,fontWeight: FontWeight.bold),) ,

        ),
        Container(
          color: Colors.transparent,
          height: 5,
        ),
        Text(
          'Upload Poll Image / Video',
          style: TextStyle(
              color: Colors.grey, fontSize: 11.0, fontWeight: FontWeight.bold),
        ),
        Container(
          width: 70.0,
          height: 90.0,
          child: FadeInImage.assetNetwork(
            placeholder: 'images/picker.png',
            image: "",
            fit: BoxFit.fill,
          ),
        ),
                 MyApp(),

              ],
            ),
          ),
        );
      },
    );

  }

  Widget page3() {

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                 VoteNeededData(),
//                 AgeRange(),

              ],
            ),
          ),
        );
      },
    );

  }
}