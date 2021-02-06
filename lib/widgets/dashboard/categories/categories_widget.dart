import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';
import 'package:wordpress_blog_app_template/models/category.dart';
import 'package:wordpress_blog_app_template/rest/rest_client.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_grid_pagination.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/categories/category_list_entry.dart';


const LIST_ITEM_SPACING = 15.0;

class CategoriesWidget extends StatefulWidget {

  const CategoriesWidget();

  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {

  RestClient restClient;

  @override
  void initState() {
    super.initState();
    restClient = context.read<RestClient>();
  }

  @override
  Widget build(BuildContext context) {
    return WPGridPagination<Category>(
      enableSingleTop: false,
      pageBuilder: (currentListSize) => loadData(context, currentListSize),
      itemBuilder: (position, category, _) => CategoryListEntry(category),
      errorLabel: context.getString('category_loading_error'),
    );
  }

  Future<List<Category>> loadData(BuildContext context, int currentListSize) async {

    var page = (currentListSize / restClient.pageSize).ceil() + 1;

    return restClient.fetchCategories(page: page);
  }
}