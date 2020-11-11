import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_blog_app_template/models/donation_type.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/height.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_html.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/donations/donation_type_icon.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';


class DonationTypeAlertDialog extends StatelessWidget {

  final DonationType type;

  const DonationTypeAlertDialog(this.type);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Wrap(
          children: [
            Column(
              children: [
                DonationTypeIcon(type),
                Text(context.getString(type.title), style: context.headline1,),
                Height(10),
                WPHtml(context.getString(type.body))
              ],
            ),
          ],
        )
    );
  }
}
