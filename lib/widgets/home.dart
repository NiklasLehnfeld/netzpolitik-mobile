import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_appbar.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_bottom_navigation.dart';
import 'package:netzpolitik_mobile/widgets/dashboard/articles/articles_widget.dart';
import 'package:netzpolitik_mobile/widgets/dashboard/categories/categories_widget.dart';


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WPAppBar(),
      bottomNavigationBar: WPBottomNavigation(
          index: _currentIndex,
          items: BOTTOM_NAV_ITEMS.map((viewHolder) => BottomNavigationBarItem(
              label: context.getString(viewHolder.titleKey),
              icon: FaIcon(viewHolder.icon)
          )).toList(),
          onTap: (index) => setState(() => _currentIndex = index)
      ),
      body: IndexedStack(
        children: BOTTOM_NAV_ITEMS.map((e) => e.child).toList(),
        index: _currentIndex,
      )
    );
  }
}

const BOTTOM_NAV_ITEMS = [
  BottomNavItemViewHolder(icon: FontAwesomeIcons.newspaper, titleKey: 'articles', child: ArticlesWidget()),
  BottomNavItemViewHolder(icon: FontAwesomeIcons.stream, titleKey: 'topics', child: CategoriesWidget()),
];

class BottomNavItemViewHolder {

  final String titleKey;
  final IconData icon;
  final Widget child;

  const BottomNavItemViewHolder({this.titleKey, this.icon, this.child});

}