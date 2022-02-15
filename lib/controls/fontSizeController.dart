import 'package:flutter/material.dart';

class FontSizeController with ChangeNotifier {
  double _value = 14.0;

  double get value => _value;

  void changeFontSize(double changedValue) {
    _value = changedValue;
    notifyListeners();
  }
}
