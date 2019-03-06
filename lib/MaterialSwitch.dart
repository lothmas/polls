library material_switch;

import 'package:flutter/material.dart';

class MaterialSwitch extends StatefulWidget {
  @required
  final List<String> options;
  @required
  final String selectedOption;
  @required
  final Function onSelect;
  @required
  final Color selectedBackgroundColor;
  @required
  final Color selectedTextColor;
  @required
  final EdgeInsets margin;
  @required
  final EdgeInsets padding;

  const MaterialSwitch({
    Key key,
    this.options,
    this.selectedOption,
    this.onSelect,
    this.selectedBackgroundColor,
    this.selectedTextColor,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  _MaterialSwitchState createState() => new _MaterialSwitchState();
}

class _MaterialSwitchState extends State<MaterialSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Row(
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              padding: widget.padding,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(30.0),
                ),
              ),
              textColor: widget.selectedOption == widget.options[0]
                  ? widget.selectedTextColor
                  : Colors.black,
              splashColor: widget.selectedOption == widget.options[0]
                  ? widget.selectedBackgroundColor
                  : Colors.white,
              color: widget.selectedOption == widget.options[0]
                  ? widget.selectedBackgroundColor
                  : Colors.white,
              highlightColor: widget.selectedOption == widget.options[0]
                  ? widget.selectedBackgroundColor
                  : Colors.white,
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text(widget.options[0],style: TextStyle(fontSize: 12),),
              ),
              onPressed: () => widget.onSelect(widget.options[0]),
            ),
          ),
          Expanded(
            child: RaisedButton(
              padding: widget.padding,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              textColor: widget.selectedOption == widget.options[1]
                  ? widget.selectedTextColor
                  : Colors.black,
              splashColor: widget.selectedOption == widget.options[1]
                  ? widget.selectedBackgroundColor
                  : Colors.white,
              color: widget.selectedOption == widget.options[1]
                  ? widget.selectedBackgroundColor
                  : Colors.white,
              highlightColor: widget.selectedOption == widget.options[1]
                  ? widget.selectedBackgroundColor
                  : Colors.white,
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text(widget.options[1],style: TextStyle(fontSize: 12)),
              ),
              onPressed: () => widget.onSelect(widget.options[1]),
            ),
          ),
        ],
      ),
    );
  }
}
