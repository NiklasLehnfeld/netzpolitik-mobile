import 'package:flutter/material.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_card.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_divider.dart';

const BORDER_RADIUS = 30.0;
const HORIZONTAL_PADDING = 15.0;

class WPBottomSheet extends StatelessWidget {

  final double? fixedHeight;
  final Widget child;

  WPBottomSheet({required this.child, this.fixedHeight});

  @override
  Widget build(BuildContext context) {
    var usesFixedHeight = fixedHeight != null;

    Widget child;

    if (usesFixedHeight) {
      child = _buildFixedHeightContent(context);
    } else {
      child = _buildDynamicHeightContent(context);
    }

    return WPCard(
      margin: EdgeInsets.zero,
      cornerRadius: BorderRadius.vertical(top: Radius.circular(BORDER_RADIUS)),
      child: child,
    );
  }

  Widget _buildDynamicHeightContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: HORIZONTAL_PADDING, right: HORIZONTAL_PADDING, bottom: HORIZONTAL_PADDING,),
      child: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: context.width,
                  margin: EdgeInsets.symmetric(vertical: (BORDER_RADIUS - WPDivider().thickness) / 2),
                  child: WPDivider()
              ),
              child,
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFixedHeightContent(BuildContext context) {
    return Container(
      height: fixedHeight,
      padding: EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: (BORDER_RADIUS - WPDivider().thickness) / 2),
              child: WPDivider()
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
