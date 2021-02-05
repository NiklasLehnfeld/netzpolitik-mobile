import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/height.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_bottom_sheet.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_link_card.dart';

class ImprintBottomSheet extends StatelessWidget {
  const ImprintBottomSheet();

  @override
  Widget build(BuildContext context) {

    var cards = [
      WPLinkCard(
        FontAwesomeIcons.github,
        context.getString('github_headline'),
        context.getString('github_url'),
        Colors.black,
      ),
      WPLinkCard(
        FontAwesomeIcons.linkedin,
        context.getString('linkedin_headline'),
        context.getString('linkedin_url'),
        Colors.blueAccent[700],
      ),
    ];

    var bottomContainer = context.isWide ?
      Row(children: cards) : Column(children: cards);

    return WPBottomSheet(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAboutAppSection(context),
        Height(15),
        _buildImprintSection(context),
        Height(15),
        bottomContainer,
        Height(20),
      ],
    ));
  }

  Widget _buildAboutAppSection(BuildContext context) => RichText(
        text: TextSpan(
          style: context.headline1,
          children: <TextSpan>[
            TextSpan(text: context.getString('about_the_app_headline') + '\n'),
            TextSpan(
                text: context.getString('about_the_app_content'),
                style: context.body2),
          ],
        ),
      );

  Widget _buildImprintSection(BuildContext context) => RichText(
        text: TextSpan(
          style: context.headline1,
          children: <TextSpan>[
            TextSpan(text: context.getString('imprint_headline') + '\n'),
            TextSpan(
                text: context.getString('imprint_content'),
                style: context.body2),
          ],
        ),
      );
}
