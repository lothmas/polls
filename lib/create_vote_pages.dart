import 'package:flutter/material.dart';
import 'package:multi_page_form/multi_page_form.dart';
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
      pageList: <Widget>[page1(), MyApp(), VoteNeededData()],
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
                  Page1(),

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

              ],
            ),
          ),
        );
      },
    );

  }
}