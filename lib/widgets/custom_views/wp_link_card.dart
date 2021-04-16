import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/width.dart';
import 'package:url_launcher/url_launcher.dart';

import 'wp_card.dart';

class WPLinkCard extends StatelessWidget {

  final IconData icon;
  final String text;
  final String link;
  final Color backgroundColor;

  const WPLinkCard(this.icon,
      this.text,
      this.link,
      this.backgroundColor);

  @override
  Widget build(BuildContext context) {
    return WPCard(
      onTap: () => launch(link),
      child: Container(
          padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
          width: context.isWide ? context.width / 2 - 30 : null,
          height: 10 * context.density,
          color: backgroundColor,
          child: Row(
            children: [
              FaIcon(
                icon,
                color: Colors.white,
                size: 25,
              ),
              Width(20),
              Text(
                text,
                style: context.headline5.copyWith(color: Colors.white),
              ),
              Spacer(),
              FaIcon(
                FontAwesomeIcons.arrowRight,
                color: Colors.white,
              ),
            ],
          )),
    );

  }

}