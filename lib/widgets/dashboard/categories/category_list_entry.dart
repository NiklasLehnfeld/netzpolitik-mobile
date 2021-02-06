import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';
import 'package:wordpress_blog_app_template/models/category.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_card.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_html.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/categories/articles_bottom_sheet.dart';

class CategoryListEntry extends StatelessWidget {

  final Category category;

  CategoryListEntry(this.category);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: WPCard(
        onTap: () => showArticles(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildName(context),
              Text('${category.count} ${context.getString('entries')}'),
              SizedBox(height: 5),
              Divider(),
              SizedBox(height: 5),
              _buildDescription(context),
            ],
          ),
        ),
      ),
    );
  }

  void showArticles(BuildContext context) => context.showBottomSheet(
    builder: (context) => ArticlesBottomSheet(filterByCategory: category),
  );


  Widget _buildDescription(BuildContext context) => WPHtml(category.description,
      style: context.body1.copyWith(color: Colors.black),);

  Widget _buildName(BuildContext context) => Text(category.name, style: context.headline4);
}