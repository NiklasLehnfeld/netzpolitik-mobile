import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_blog_app_template/models/donation_type.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/donations/donation_type_alert_dialog.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/donations/donation_type_icon.dart';

class DonationTypeListEntry extends StatelessWidget {
  final DonationType type;

  const DonationTypeListEntry(this.type);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          InkWell(
            onTap: () => showDonationDialog(context),
            child: DonationTypeIcon(type)
          ),
        ],
      ),
    );
  }

  void showDonationDialog(BuildContext context) => context.navigate((context) => DonationTypeAlertDialog(type), isDialog: true);
}



