import 'package:flutter/material.dart';

enum Statuss { none, correct, wrong }

class Country {
  final int id;
  final String city;
  final String country;
  bool _selected = false;

  bool get selected => _selected;

  void set selected(bool value) {
    _selected = value;
    if( _selected == false )
      status = Statuss.none;
  }
  Statuss status;

  Country(this.id, this.city, this.country, {this.status: Statuss.none});

  @override
  String toString() {
    return 'Item{id: $id, city: $city, country: $country,'
      ' selected: $selected, status: $status}';
  }
}

Color getDropBorderColor(Statuss status) {
  Color c;
  switch (status) {
    case Statuss.none:
      c = Colors.grey[300];
      break;
    case Statuss.correct:
      c = Colors.lime[300];
      break;
    case Statuss.wrong:
      c = Colors.orange[300];
      break;
  }
  return c;
}