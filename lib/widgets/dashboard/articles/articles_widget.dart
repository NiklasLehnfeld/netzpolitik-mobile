import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paging/paging.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_blog_app_template/models/article.dart';
import 'package:wordpress_blog_app_template/rest/RestClient.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/articles/article_list_entry.dart';

const LIST_ITEM_SPACING = 15.0;

class ArticlesWidget extends StatefulWidget {

  const ArticlesWidget();

  @override
  _ArticlesWidgetState createState() => _ArticlesWidgetState();
}

class _ArticlesWidgetState extends State<ArticlesWidget> {

  RestClient restClient;

  @override
  void initState() {
    restClient = context.read<RestClient>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Pagination<Article>(
      pageBuilder: (currentListSize) => loadData(context, currentListSize),
      itemBuilder: (index, article) => Container(
        child: ArticleListEntry(article),
        margin: EdgeInsets.only(bottom: LIST_ITEM_SPACING),
      )
    );
  }

  Future<List<Article>> loadData(BuildContext context, int currentListSize) async {

    var page = currentListSize ~/ restClient.pageSize + 1;

    return restClient.fetchArticles(page: page);
  }
}