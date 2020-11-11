import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wordpress_blog_app_template/models/donation_type.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';


class DonationTypeIcon extends StatelessWidget {

  final DonationType type;

  const DonationTypeIcon(this.type);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'donation_${toString()}_icon',
      child: Container(
        margin: EdgeInsets.all(12),
        width: 100,
        height: 100,
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: FaIcon(
          type.iconData,
          size: 50,
          color: Colors.white,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: context.primaryColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 4.0,
              spreadRadius: 0.0,
              offset: Offset(5.0, 5.0),
            )
          ],
        ),
      ),
    );
  }

}