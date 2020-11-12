import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';
import 'package:wordpress_blog_app_template/models/article.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_back_button.dart';

class WPArticleAppBar extends StatelessWidget implements PreferredSizeWidget {

  final Article article;
  
  WPArticleAppBar(this.article);
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.scaffoldColor,
      leading: WPBackButton(),
      actions: [
        IconButton(icon: FaIcon(FontAwesomeIcons.solidCommentAlt, color: context.iconButtonColor,), onPressed: showComments),
        IconButton(icon: FaIcon(FontAwesomeIcons.userAlt, color: context.iconButtonColor,), onPressed: showAuthor,)
      ],
    );
  }

  void showComments() {

  }

  void showAuthor() {

  }

  @override
  Size get preferredSize => AppBar().preferredSize;

}