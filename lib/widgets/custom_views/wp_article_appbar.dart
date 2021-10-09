import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/models/article.dart';
import 'package:netzpolitik_mobile/models/author.dart';
import 'package:netzpolitik_mobile/models/category.dart';
import 'package:netzpolitik_mobile/models/reply.dart';
import 'package:netzpolitik_mobile/persistence/article_dao.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_back_button.dart';
import 'package:netzpolitik_mobile/widgets/dashboard/articles/author/author_bottom_sheet.dart';
import 'package:netzpolitik_mobile/widgets/dashboard/articles/replies/replies_bottom_sheet.dart';
import 'package:provider/provider.dart';

class WPArticleAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Article article;

  const WPArticleAppBar(this.article);

  @override
  _WPArticleAppBarState createState() => _WPArticleAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _WPArticleAppBarState extends State<WPArticleAppBar> {

  bool _bookmarked = false;

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
        bookmarkButton(context),
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

  Widget bookmarkButton(BuildContext context) {

    final dao = context.watch<ArticleDAO>();

    return FutureBuilder<bool>(
      future: dao.isStored(widget.article),
      builder: (context, snapshot) {

        if (snapshot.hasData && snapshot.data != null) {
          _bookmarked = snapshot.data!;
        }

        return IconButton(
          icon: FaIcon(
            _bookmarked ? FontAwesomeIcons.solidBookmark : FontAwesomeIcons.bookmark,
            color: context.iconButtonColor,
          ),
          onPressed: () async {
            if (_bookmarked) {
              await dao.delete(widget.article.id!);
            } else {
              await dao.insert(widget.article);
            }
            setState(() {
              _bookmarked = !_bookmarked;
            });
          },
        );
      }
    );
  }

  void showReplies(BuildContext context) => context.showBottomSheet(
    builder: (context) => RepliesBottomSheet(
        replies.where((e) => e != null).map((e) => e as Reply).toList()
    ),
  );

  void showAuthor(BuildContext context) => context.showBottomSheet(
    builder: (context) => AuthorBottomSheet(authors),
  );


}
