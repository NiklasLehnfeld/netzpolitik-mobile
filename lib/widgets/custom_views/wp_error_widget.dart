import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';

const ERROR_ICON_SIZE = 70.0;

class WPErrorWidget extends StatelessWidget {

  final String text;
  final Function onPress;
  final IconData icon;

  WPErrorWidget({this.text, this.onPress, this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          iconSize: ERROR_ICON_SIZE,
          icon: FaIcon(
            icon ?? FontAwesomeIcons.syncAlt,
            color: context.primaryColor,
          ),
          onPressed: onPress,
        ),
        Container(
          width: 300,
          child: Text(
            text,
            style: context.headline6,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

}