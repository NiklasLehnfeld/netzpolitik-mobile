import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';

class NetzpolitikTitle extends StatelessWidget {
  const NetzpolitikTitle();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        context.isDarkTheme ?
          'assets/netzpolitik_logo_dark.png' :
          'assets/netzpolitik_logo.png',
        width: 200,
      ),
    );
  }
}
