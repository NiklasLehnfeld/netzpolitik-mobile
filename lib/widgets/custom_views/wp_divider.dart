import 'package:flutter/material.dart';

class WPDivider extends StatelessWidget {

  final double thickness;
  final double width;
  final Color color;

  WPDivider({this.thickness = 5, this.width = 100, this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(1000),
          child: Container(
            height: thickness,
            width: width,
            color: color,
          ),
        ),
      ],
    );
  }

}