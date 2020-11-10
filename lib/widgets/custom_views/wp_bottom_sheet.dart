import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_card.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_divider.dart';

const BORDER_RADIUS = 30.0;
const HORIZONTAL_PADDING = 15.0;
const SHEET_HEIGHT_FACTOR = 0.85;

class WPBottomSheet extends StatelessWidget {
  final Widget child;

  WPBottomSheet({@required this.child});

  @override
  Widget build(BuildContext context) {
    return WPCard(
      margin: EdgeInsets.zero,
      cornerRadius: BorderRadius.circular(BORDER_RADIUS),
      child: Container(
          height: context.height * SHEET_HEIGHT_FACTOR,
          padding: EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: (BORDER_RADIUS - WPDivider().thickness) / 2),
                  child: WPDivider()
              ),
              Expanded(child: child),
            ],
          )),
    );
  }
}
