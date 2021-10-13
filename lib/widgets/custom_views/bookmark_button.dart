import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/models/article.dart';
import 'package:netzpolitik_mobile/persistence/article_dao.dart';
import 'package:provider/provider.dart';

class BookmarkButtonWidget extends StatefulWidget {

  final Article article;
  final bool hasPadding;
  final Color? color;

  const BookmarkButtonWidget(this.article, {this.hasPadding = true, this.color});

  @override
  State<BookmarkButtonWidget> createState() => _BookmarkButtonWidgetState();
}

class _BookmarkButtonWidgetState extends State<BookmarkButtonWidget> {

  bool _bookmarked = false;

  @override
  Widget build(BuildContext context) {
    final dao = context.watch<ArticleDAO>();

    return FutureBuilder<bool>(
        future: dao.isStored(widget.article),
        builder: (context, snapshot) {

          if (snapshot.hasData && snapshot.data != null) {
            _bookmarked = snapshot.data!;
          }

          return IconButton(
            padding: widget.hasPadding ? EdgeInsets.all(8.0) : EdgeInsets.zero,
            constraints: widget.hasPadding ? null : BoxConstraints(),
            icon: FaIcon(
              _bookmarked ? FontAwesomeIcons.solidBookmark : FontAwesomeIcons.bookmark,
              color: widget.color ?? context.iconButtonColor,
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
}