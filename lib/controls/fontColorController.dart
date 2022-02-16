import 'package:flutter/material.dart';

class FontColorController extends ChangeNotifier {
  Color _value = Colors.black;
  String _stringValue = 'Black';

  String get stringValue => _stringValue;
  Color get value => _value;

  Map<String, Color> colorMap = {
    "Black" : Colors.black,
    "Red" : Colors.red,
  };

  void changeFontColor(String colorValue) {
    _stringValue = colorValue;
    _value = colorMap[colorValue]!;
    notifyListeners();
  }
}
