import 'package:flutter/material.dart';

class FontColorController extends ChangeNotifier {
  Color _value = Colors.black;
  
  Color get value => _value;

  Map<String, Color> colorMap = {
    "Black" : Colors.black,
    "Red" : Colors.red,
  };

  void changeFontColor(Color colorValue) {
    //_stringValue = colorValue;
    _value = colorValue;
    notifyListeners();
  }
}
