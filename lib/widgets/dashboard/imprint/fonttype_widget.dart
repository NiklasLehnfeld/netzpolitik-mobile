import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netzpolitik_mobile/persistence/app_settings.dart';
import 'package:provider/provider.dart';

class FonttypeWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => FonttypeWidgetState();

}

class FonttypeWidgetState extends State<FonttypeWidget> {

  String? get _style {
    var appSettings = context.read<AppSettings>();
    return appSettings.fontType;
  }

  set _style(String? value) {
    var appSettings = context.read<AppSettings>();
    appSettings.fontType = value;
  }

  @override
  Widget build(BuildContext context) {

    var settings = context.watch<AppSettings>();

    return DropdownButton<String>(
      value: _style,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.red, fontSize: 18),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? data) {
        setState(() {
          _style = data;
        });
      },
      items: settings.fonts.map((e) {
        var name = e.key;
        var style = e.value;
        return DropdownMenuItem<String>(
          value: name,
          child: Text(name, style: style().copyWith(color: Colors.black),),
        );
      }).toList()
    );
  }

}