import 'package:flutter/cupertino.dart';

class WPExpandedSection extends StatefulWidget {

  static const ANIMATION_DURATION = 500;

  final Widget child;
  final bool expand;
  WPExpandedSection({this.expand = false, this.child});

  @override
  _WPExpandedSectionState createState() => _WPExpandedSectionState();
}

class _WPExpandedSectionState extends State<WPExpandedSection> with SingleTickerProviderStateMixin {
  AnimationController expandController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  void prepareAnimations() {
    expandController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: WPExpandedSection.ANIMATION_DURATION ),
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if(widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(WPExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axisAlignment: 1.0,
        sizeFactor: animation,
        child: widget.child
    );
  }
}