import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/models/article.dart';
import 'package:share/share.dart';

class ShareButtonWidget extends StatelessWidget {

  final Article article;
  final bool hasPadding;
  final Color? color;

  const ShareButtonWidget(this.article, {this.hasPadding = true, this.color});

  @override
  Widget build(BuildContext context) {
    var url = article.link;

    if (url == null) {
      return Container();
    }

    return IconButton(
      padding: hasPadding ? EdgeInsets.all(8.0) : EdgeInsets.zero,
      constraints: hasPadding ? null : BoxConstraints(),
      icon: FaIcon(
       FontAwesomeIcons.shareAlt,
        color: color ?? context.iconButtonColor,
      ),
      onPressed: () async {
        await Share.share(url);
      },
    );
  }



}