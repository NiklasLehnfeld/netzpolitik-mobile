import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_blog_app_template/models/category.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_bottom_sheet.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/articles/articles_list.dart';

class ArticlesBottomSheet extends StatelessWidget {
  final Category filterByCategory;
  final String filterByTerm;

  ArticlesBottomSheet({this.filterByCategory, this.filterByTerm});

  @override
  Widget build(BuildContext context) {

    return WPBottomSheet(
        child: ArticlesList(
          categoryFilter: filterByCategory,
          contentFilter: filterByTerm,
        )
    );
  }
}
