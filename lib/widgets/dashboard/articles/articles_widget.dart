import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_blog_app_template/models/article.dart';
import 'package:wordpress_blog_app_template/rest/RestClient.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_progress_indicator.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/articles/article_list_entry.dart';


const LIST_ITEM_SPACING = 10.0;

class ArticlesWidget extends StatelessWidget {

  const ArticlesWidget();

  @override
  Widget build(BuildContext context) {

    var restClient = context.watch<RestClient>();

    return FutureBuilder(
      future: restClient.fetchArticles(),
      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return WPProgressIndicator();
        }

        var articles = snapshot.data as List<Article>;

        return ListView.separated(
          itemCount: articles.length,
          itemBuilder: (context, index) => ArticleListEntry(articles[index]),
          separatorBuilder: (context, index) => SizedBox(height: LIST_ITEM_SPACING),
        );
      },
    );
  }
}