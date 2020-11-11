import 'package:flutter/cupertino.dart';
import 'package:paging/paging.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_blog_app_template/models/article.dart';
import 'package:wordpress_blog_app_template/models/category.dart';
import 'package:wordpress_blog_app_template/rest/RestClient.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/articles/article_list_entry.dart';

const LIST_ITEM_SPACING = 15.0;

class ArticlesList extends StatelessWidget {

  final Category categoryFilter;
  final String contentFilter;

  ArticlesList({this.categoryFilter, this.contentFilter});

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

    var restClient = context.read<RestClient>();

    var page = (currentListSize / restClient.pageSize).ceil() + 1;

    var result = await restClient.fetchArticles(page: page, category: categoryFilter, searchTerm: contentFilter);

    result = result.where((element) => element.imageUrl != null).toList();

    return result;
  }


}