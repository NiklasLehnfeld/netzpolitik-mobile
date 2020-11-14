import 'package:flutter/cupertino.dart';

class Width extends StatelessWidget {

  final double width;

  const Width(this.width);

  @override
  Widget build(BuildContext context) => SizedBox(width: width);


}