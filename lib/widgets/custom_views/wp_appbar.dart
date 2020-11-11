import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_blog_app_template/config/app_configuration.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/categories/articles_bottom_sheet.dart';

class WPAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _WPAppBarState createState() => _WPAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _WPAppBarState extends State<WPAppBar> {
  SearchBar _searchBar;

  Widget _buildAppBar(BuildContext context) {
    var appConfig = context.watch<AppConfiguration>();

    return AppBar(
      backgroundColor: Colors.white,
      title: Container(
        alignment: Alignment.centerLeft,
        child: appConfig.title ?? Text(appConfig.name),
      ),
      actions: [
        IconButton(
            icon: FaIcon(
              FontAwesomeIcons.search,
              color: context.primaryColor,
            ),
            onPressed: () => _searchBar.beginSearch(context))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _searchBar = _searchBar ?? _buildSearchBar(context);
    return _searchBar.build(context);
  }

  SearchBar _buildSearchBar(BuildContext context) => SearchBar(
        setState: setState,
        buildDefaultAppBar: _buildAppBar,
        inBar: false,
        onSubmitted: (term) => showArticles(context, term),
        hintText: context.getString('search_hint'),
      );

  void showArticles(BuildContext context, String term) => showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => ArticlesBottomSheet(filterByTerm: term,),
    isScrollControlled: true,
  );
}
