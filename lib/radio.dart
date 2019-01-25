import 'package:flutter/material.dart';

class YesNoMaybe extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CurrencyState();
  }
}

class _CurrencyState extends State<YesNoMaybe> {
  final TextEditingController _currencyController = new TextEditingController();
  int _radioValue = 0;

  static const EURO_MUL = 0.86;
  static const POUND_MUL = 0.75;
  static const YEN_MUL = 110.63;
  double _result = 0.0;
  String _textResult = '';

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          _result = _currencyCalculate(_currencyController.text, EURO_MUL);
          if (_result > -1.0) {
            _textResult =
                '${_currencyController.text} USD = ${_result.toStringAsFixed(3)} Euro';
          } else {
            _textResult =
                'Cannot convert USD to Euro\nPlease check the Amount!';
          }
          break;
        case 1:
          _result = _currencyCalculate(_currencyController.text, POUND_MUL);
          if (_result > -1.0) {
            _textResult =
                '${_currencyController.text} USD = ${_result.toStringAsFixed(3)} Pound';
          } else {
            _textResult =
                'Cannot convert USD to Pound\nPlease check the Amount!';
          }
          break;
        case 2:
          _result = _currencyCalculate(_currencyController.text, YEN_MUL);
          if (_result > -1.0) {
            _textResult =
                '${_currencyController.text} USD = ${_result.toStringAsFixed(3)} Yen';
          } else {
            _textResult = 'Cannot convert USD to Yen\nPlease check the Amount!';
          }
          break;
      }
    });
  }

  void _handleCurrencyAmountChange(String amount) {
    setState(() {
      switch (_radioValue) {
        case 0:
          _result = _currencyCalculate(amount, EURO_MUL);
          if (_result > -1.0) {
            _textResult = '$amount USD = ${_result.toStringAsFixed(3)} Euro';
          } else {
            _textResult =
                'Cannot convert USD to Euro\nPlease check the Amount!';
          }
          break;
        case 1:
          _result = _currencyCalculate(amount, POUND_MUL);
          if (_result > -1.0) {
            _textResult = '$amount USD = ${_result.toStringAsFixed(3)} Pound';
          } else {
            _textResult =
                'Cannot convert USD to Pound\nPlease check the Amount!';
          }
          break;
        case 2:
          _result = _currencyCalculate(amount, YEN_MUL);
          if (_result > -1.0) {
            _textResult = '$amount USD = ${_result.toStringAsFixed(3)} Yen';
          } else {
            _textResult = 'Cannot convert USD to Yen\nPlease check the Amount!';
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Radio(
                              value: 1,
                              groupValue: _radioValue,
                              onChanged: _handleRadioValueChange,
                            ),
                            new Text(
                              'No',
                              style: TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            new Radio(
                              value: 0,
                              groupValue: _radioValue,
                              onChanged: _handleRadioValueChange,
                            ),
                            new Text(
                              'Yes',
                              style: TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            new Radio(
                              value: 2,
                              groupValue: _radioValue,
                              onChanged: _handleRadioValueChange,
                            ),
                            new Text(
                              'Maybe',
                              style: TextStyle(fontSize: 11),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
    );
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
