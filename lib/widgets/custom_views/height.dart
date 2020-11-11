import 'package:flutter/cupertino.dart';

class Height extends StatelessWidget {

  final double height;

  const Height(this.height);

  @override
  Widget build(BuildContext context) => SizedBox(height: height);

}