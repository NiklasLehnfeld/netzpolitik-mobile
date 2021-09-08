import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WPCard extends StatefulWidget {

  final Widget child;
  final EdgeInsets? margin;
  final BorderRadius? cornerRadius;
  final EdgeInsets? padding;
  final double tappedElevation;
  final double defaultElevation;
  final VoidCallback? onTap;

  WPCard({
    required this.child,
    this.tappedElevation = 1.0,
    this.defaultElevation = 8.0,
    this.onTap,
    this.margin,
    this.cornerRadius,
    this.padding
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
      onTap: widget.onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: widget.cornerRadius ?? BorderRadius.circular(8.0)
        ),
        margin: widget.margin,
        elevation: tapped ? widget.tappedElevation : widget.defaultElevation,
        child: Padding(
          padding: widget.padding ?? EdgeInsets.zero,
          child: widget.child,
        ),
      ),
    );
  }
}