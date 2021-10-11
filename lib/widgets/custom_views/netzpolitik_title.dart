import 'package:flutter/cupertino.dart';

class NetzpolitikTitle extends StatelessWidget {
  const NetzpolitikTitle();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/netzpolitik_logo.png',
        width: 200,
      ),
    );
  }
}
