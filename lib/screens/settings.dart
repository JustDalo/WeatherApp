import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_application/controls/fontSizeController.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        ListTile(
          title: Text("Font size",
              style: TextStyle(
                  fontSize:
                      Provider.of<FontSizeController>(context, listen: true)
                          .value)),
        ),
        buildFontSize(),
      ],
    ));
  }

  Widget buildFontSize() => Slider(
        value: Provider.of<FontSizeController>(context, listen: true).value,
        max: 20,
        min: 10,
        divisions: 5,
        label: Provider.of<FontSizeController>(context, listen: true)
            .value
            .round()
            .toString(),
        onChanged: (double value) {
          Provider.of<FontSizeController>(context, listen: false)
              .changeFontSize(value);
        },
      );
}

// child: Text(
// "Change type size: ",
// style: TextStyle(fontSize: Provider
//     .of<FontSizeController>(context, listen: true)
// .value),
//
// Slider(
// value: _currentSliderValue,
// max: 20,
// min: 10,
// divisions: 1,
// label: _currentSliderValue.round().toString(),
// onChanged: (double value) {
// setState(() {
// _currentSliderValue = value;
// });
// Provider.of<FontSizeController>(context, listen: false)
//     .changeFontSize(value);
// },
// ),
