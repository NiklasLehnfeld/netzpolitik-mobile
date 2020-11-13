import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';
import 'package:wordpress_blog_app_template/models/category.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_bottom_sheet.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/articles/articles_list.dart';

const SHEET_HEIGHT_FACTOR = 0.85;

class ArticlesBottomSheet extends StatelessWidget {
  final Category filterByCategory;
  final String filterByTerm;

  ArticlesBottomSheet({this.filterByCategory, this.filterByTerm});

  @override
  Widget build(BuildContext context) {

    return WPBottomSheet(
        fixedHeight: context.height * SHEET_HEIGHT_FACTOR,
        child: ArticlesList(
          categoryFilter: filterByCategory,
          contentFilter: filterByTerm,
        )
    );
  }
}
