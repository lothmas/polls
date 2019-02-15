library multi_page_form;
import 'package:flutter/material.dart';
import 'package:stats/vote_by_dropdown.dart';

class MultiPageForm extends StatefulWidget {
  final VoidCallback onFormSubmitted;
  final int totalPage;
  final Widget nextButtonStyle;
  final Widget previousButtonStyle;
  final Widget submitButtonStyle;
  final List<Widget> pageList;
  MultiPageForm(
      {
        @required this.totalPage,
        @required this.pageList,
        @required this.onFormSubmitted,
        this.nextButtonStyle,
        this.previousButtonStyle,
        this.submitButtonStyle});


  MultiPageFormState createState() => MultiPageFormState();
}

class MultiPageFormState extends State<MultiPageForm> {
  int totalPage;
  int currentPage = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalPage = widget.totalPage;
  }

  Widget getNextButtonWrapper(Widget child){
    if(widget.nextButtonStyle !=null){
      return child;
    }
    else{
      return Row(children: <Widget>[
        Text("Next  ",style: TextStyle(color: Colors.blueGrey),),
        Image.asset("images/next.png",height: 24,width: 24,)],);
    }
  }

  Widget getPreviousButtonWrapper(Widget child){
    if(widget.previousButtonStyle !=null){
      return child;
    }
    else{
      return Row(children: <Widget>[
        Image.asset("images/previous.png",height: 24,width: 24,),
        Text("  Previous",style: TextStyle(color: Colors.blueGrey),
        )],);
    }
  }

  Widget getSubmitButtonWrapper(Widget child){
    if(widget.previousButtonStyle !=null){
      return child;
    }
    else{
      return Row(children: <Widget>[
        Text("Submit  ",style: TextStyle(color: Colors.blueGrey),),
        Image.asset("images/submit.png",height: 24,width: 24,)],);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: pageHolder(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                currentPage == 1
                    ? Container()
                    : FlatButton(
                  child: getPreviousButtonWrapper(widget.previousButtonStyle),
                  onPressed: () {
                    setState(() {
                      currentPage = currentPage - 1;
                    });
                  },
                ),
                currentPage == totalPage
                    ? FlatButton(
                  child: getSubmitButtonWrapper(widget.submitButtonStyle),
                  onPressed: widget.onFormSubmitted,
                )
                    : FlatButton(
                  child: getNextButtonWrapper(widget.nextButtonStyle),
                  onPressed: () {
                    setState(() {
                      BuildContext voteBy= SettingsWidgetState().context;
                      currentPage = currentPage + 1;

                    });
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget pageHolder() {
    for (int i = 1; i <= totalPage; i++) {
      if (currentPage == i) {
        return widget.pageList[i - 1];
      }
    }
    return Container();
  }
}
