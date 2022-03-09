import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/controls/FontColorController.dart';

import 'package:weather_application/controls/FontSizeController.dart';
import 'package:weather_application/dao/DAO.dart';
import 'package:weather_application/model/Weather.dart';

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
                          .value,
                  color: Provider.of<FontColorController>(context, listen: true)
                      .value)),
          tileColor: Colors.grey,
        ),
        _buildFontSize(),
        ListTile(
          title: Text("Font color",
              style: TextStyle(
                  fontSize:
                      Provider.of<FontSizeController>(context, listen: true)
                          .value,
                  color: Provider.of<FontColorController>(context, listen: true)
                      .value)),
          tileColor: Colors.grey,
        ),
        _buildFontColor(),
      ],
    ));
  }

  Widget _buildFontSize() => Container(
      width: double.maxFinite,
      child: CupertinoSlider(
        value: Provider.of<FontSizeController>(context, listen: true).value,
        max: 20,
        min: 10,
        divisions: 5,

        /*label: Provider.of<FontSizeController>(context, listen: true)
            .value
            .round()
            .toString(),*/
        onChanged: (double value) {
          Provider.of<FontSizeController>(context, listen: false)
              .changeFontSize(value);
        },
      ));



  Widget _buildFontColor() => ColorPicker(
        pickerColor:
            Provider.of<FontColorController>(context, listen: true).value,
        onColorChanged: (color) {
          Provider.of<FontColorController>(context, listen: false)
              .changeFontColor(color);
        },
        colorPickerWidth: 300.0,
        pickerAreaHeightPercent: 0.7,
        enableAlpha: true,
        displayThumbColor: true,
        showLabel: true,
        paletteType: PaletteType.hsv,
        pickerAreaBorderRadius: const BorderRadius.only(
          topLeft: Radius.circular(2.0),
          topRight: Radius.circular(2.0),
        ),
      );
}
