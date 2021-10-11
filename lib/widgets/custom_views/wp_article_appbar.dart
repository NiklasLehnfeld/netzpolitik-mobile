import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/models/article.dart';
import 'package:netzpolitik_mobile/models/author.dart';
import 'package:netzpolitik_mobile/models/category.dart';
import 'package:netzpolitik_mobile/models/reply.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/bookmark_button.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_back_button.dart';
import 'package:netzpolitik_mobile/widgets/dashboard/articles/author/author_bottom_sheet.dart';
import 'package:netzpolitik_mobile/widgets/dashboard/articles/replies/replies_bottom_sheet.dart';

class WPArticleAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Article article;

  const WPArticleAppBar(this.article);

  @override
  _WPArticleAppBarState createState() => _WPArticleAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _WPArticleAppBarState extends State<WPArticleAppBar> {

  List<Author> get authors => widget.article.authors ?? [];
  List<Reply?> get replies => widget.article.replies ?? [];
  List<Category> get categories => widget.article.categories ?? [];

  @override
  Widget build(BuildContext context) {

    return AppBar(
      elevation: 0,
      backgroundColor: context.scaffoldColor,
      leading: WPBackButton(),
      actions: [
        BookmarkButtonWidget(widget.article),
        repliesButton(context),
        authorButton(context),
      ],
    );
  }

  Widget authorButton(BuildContext context) => IconButton(
    icon: FaIcon(
      FontAwesomeIcons.userAlt,
      color: context.iconButtonColor,
    ),
    onPressed: () => showAuthor(context),
  );

  Widget repliesButton(BuildContext context) => IconButton(
      icon: FaIcon(
        FontAwesomeIcons.solidCommentAlt,
        color: replies.isNotEmpty ? context.iconButtonColor : null,
      ),
      onPressed: replies.isNotEmpty ? () => showReplies(context) : null);

  void showReplies(BuildContext context) => context.showBottomSheet(
    builder: (context) => RepliesBottomSheet(
        replies.where((e) => e != null).map((e) => e as Reply).toList()
    ),
  );

  void showAuthor(BuildContext context) => context.showBottomSheet(
    builder: (context) => AuthorBottomSheet(authors),
  );


}
