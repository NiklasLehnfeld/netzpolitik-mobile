import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/models/article.dart';
import 'package:netzpolitik_mobile/models/category.dart';
import 'package:netzpolitik_mobile/rest/rest_client.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_grid_pagination.dart';
import 'package:netzpolitik_mobile/widgets/dashboard/articles/article_list_entry.dart';
import 'package:provider/provider.dart';



class ArticlesList extends StatefulWidget {
  final Category categoryFilter;
  final String contentFilter;

  ArticlesList({this.categoryFilter, this.contentFilter});

  @override
  _ArticlesListState createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return WPGridPagination<Article>(
      itemBuilder: (position, article, isBig) => ArticleListEntry(article, isBig: isBig),
      pageBuilder: (listSize) => loadData(context, listSize),
      errorLabel: context.getString('article_loading_error'),
    );
  }

  Future<List<Article>> loadData(
      BuildContext context, int currentListSize) async {
    var restClient = context.read<RestClient>();

    var pageSize = restClient.pageSize;

    if (context.isUltraWide) {
      pageSize = pageSize * 2;
    }

    var page = (currentListSize / restClient.pageSize).ceil() + 1;


    var result = await restClient.fetchArticles(
        page: page,
        category: widget.categoryFilter,
        searchTerm: widget.contentFilter);

    result = result.where((element) => element.imageName != null).toList();

    return result;
  }

}
