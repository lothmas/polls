import 'package:flutter/material.dart';

class GridViewItem extends StatelessWidget {
  final Image _iconData;
  final bool _isSelected;

  GridViewItem(this._iconData, this._isSelected);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: _iconData,

//      Icon(
//        _iconData,
//        color: Colors.white,
//      ),
      shape:  Border.all(
      color: Colors.black,
      width: 1.0,
    ) ,
      fillColor: _isSelected ? Colors.grey[100] : Colors.transparent,
      onPressed: null,
    );
  }
}