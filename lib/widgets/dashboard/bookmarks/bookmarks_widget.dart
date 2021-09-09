import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/models/article.dart';
import 'package:netzpolitik_mobile/persistence/article_dao.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_error_widget.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_grid_pagination.dart';
import 'package:netzpolitik_mobile/widgets/dashboard/articles/article_list_entry.dart';
import 'package:provider/provider.dart';

class BookmarksWidget extends StatefulWidget {

  const BookmarksWidget();

  @override
  _BookmarksWidgetState createState() => _BookmarksWidgetState();
}

class _BookmarksWidgetState extends State<BookmarksWidget> implements ArticleDAOListener {

  late ArticleDAO _articleDAO;

  @override
  void initState() {
    _articleDAO = context.read<ArticleDAO>();
    _articleDAO.listen(this);
    super.initState();
  }


  @override
  void dispose() {
    _articleDAO.unlisten(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Article>>(
      future: _articleDAO.getAll(),
      builder: (context, snapshot) {
        //loading
        if (snapshot.connectionState != ConnectionState.done) {
          return CircularProgressIndicator();
        }

        final articles = snapshot.data;
        if (articles == null || articles.isEmpty) {
          return _buildEmptyWidget(context);
        } else {
          return _buildContent(context, articles);
        }
      },
    );
  }

  Widget _buildEmptyWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: WPErrorWidget(
          text: context.getString('no_bookmarks'),
          icon: FontAwesomeIcons.sadCry,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<Article> articles) {
    return WPGridPagination<Article>(
      itemBuilder: (position, article, isBig) => ArticleListEntry(article, isBig: isBig, identifier: 'bookmark'),
      pageBuilder: (listSize) => Future.value(articles.sublist(listSize, math.min(articles.length, listSize + 10))),
      errorLabel: context.getString('article_loading_error'),
    );
  }

  @override
  void onContentChanged() => setState(() {});
}