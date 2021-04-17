import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netzpolitik_mobile/config/app_configuration.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/widgets/dashboard/categories/articles_bottom_sheet.dart';
import 'package:netzpolitik_mobile/widgets/dashboard/imprint/imprint_bottom_sheet.dart';
import 'package:provider/provider.dart';

class WPAppBar extends StatefulWidget implements PreferredSizeWidget {

  const WPAppBar();

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
        _buildSearchButton(context),
        _buildImprintButton(context),
      ],
    );
  }

  Widget _buildSearchButton(BuildContext context) => IconButton(
        icon: FaIcon(
          FontAwesomeIcons.search,
          color: context.primaryColor,
        ),
        onPressed: () => _searchBar.beginSearch(context),
      );

  Widget _buildImprintButton(BuildContext context) => IconButton(
        icon: FaIcon(
          FontAwesomeIcons.userCog,
          color: context.primaryColor,
        ),
        onPressed: () => context.showBottomSheet(
          builder: (context) => ImprintBottomSheet(),
        ),
      );

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

  void showArticles(BuildContext context, String term) =>
      context.showBottomSheet(
        builder: (context) => ArticlesBottomSheet(filterByTerm: term),
      );
}
