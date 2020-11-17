import 'package:flutter/cupertino.dart';

class NetzpolitikTitle extends StatelessWidget {
  const NetzpolitikTitle();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      child: Image.asset(
        'assets/netzpolitik_logo.png',
        width: 450,
      ),
    );
  }
}
