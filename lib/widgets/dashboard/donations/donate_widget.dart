import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';
import 'package:wordpress_blog_app_template/models/donation_type.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/height.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_expandable_panel.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/donations/donation_type_list_entry.dart';

class DonateWidget extends StatelessWidget {
  const DonateWidget();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Height(20),
            Text(
              context.getString('donate_title'),
              style: context.headline1.copyWith(color: Colors.grey[800]),
            ),
            Height(8),
            WPExpandablePanel(
              title: context.getString('donate_description_title'),
              body: context.getString('donate_description'),
            ),
            Height(20),
            Text(
              context.getString('how_to_donate'),
              style: context.headline1.copyWith(color: Colors.grey[800]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDonationTypeRow([DonationType.TRANSFER, DonationType.CRYPTO]),
                  Height(20),
                  DonationType.CASH.toListEntry(),
                  Height(20),
                  _buildDonationTypeRow([DonationType.PAYPAL, DonationType.SMS]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDonationTypeRow(List<DonationType> types) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: types.map((e) => e.toListEntry()).toList()
  );
}

extension on DonationType {

  Widget toListEntry() => DonationTypeListEntry(this);

}


