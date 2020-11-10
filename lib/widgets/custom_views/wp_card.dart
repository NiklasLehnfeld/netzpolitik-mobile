import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WPCard extends StatefulWidget {

  final Widget child;
  final EdgeInsets margin;
  final BorderRadius cornerRadius;
  final double tappedElevation;
  final double defaultElevation;
  final Function onTap;

  WPCard({
    @required this.child,
    this.tappedElevation = 1.0,
    this.defaultElevation = 8.0,
    this.onTap,
    this.margin,
    this.cornerRadius
  });

  @override
  _WPCardState createState() => _WPCardState();
}

class _WPCardState extends State<WPCard> {

  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapDown: (d) => setState(() => tapped = true),
      onTap: () {
        setState(() => tapped = false);
        if (widget.onTap != null) {
          widget.onTap();
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: widget.cornerRadius ?? BorderRadius.circular(8.0)
        ),
        margin: widget.margin,
        elevation: tapped ? widget.tappedElevation : widget.defaultElevation,
        child: widget.child,
      ),
    );
  }
}