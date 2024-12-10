import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netzpolitik_mobile/dialogs/theme_mode_dialog.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/theme/theme_mode_provider.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_appbar.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_bottom_navigation.dart';
import 'package:netzpolitik_mobile/widgets/dashboard/articles/articles_widget.dart';
import 'package:netzpolitik_mobile/widgets/dashboard/articles/podcasts_widget.dart';
import 'package:netzpolitik_mobile/widgets/dashboard/bookmarks/bookmarks_widget.dart';
import 'package:provider/provider.dart';

import 'dashboard/support/support_widget.dart';


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WPAppBar(),
      bottomNavigationBar: WPBottomNavigation(
          index: _currentIndex,
          items: BOTTOM_NAV_ITEMS.map((viewHolder) => BottomNavigationBarItem(
              label: context.getString(viewHolder.titleKey),
              icon: FaIcon(viewHolder.icon,)
          )).toList(),
          onTap: (index) => setState(() => _currentIndex = index)
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: BOTTOM_NAV_ITEMS.map((e) => e.child).toList(),
      )
    );
  }
}

const BOTTOM_NAV_ITEMS = [
  BottomNavItemViewHolder(icon: FontAwesomeIcons.home, titleKey: 'home', child: ArticlesWidget()),
  BottomNavItemViewHolder(icon: FontAwesomeIcons.headphones, titleKey: 'podcasts', child: PodcastsWidget()),
  BottomNavItemViewHolder(icon: FontAwesomeIcons.bookmark, titleKey: 'bookmarks', child: BookmarksWidget()),
  BottomNavItemViewHolder(icon: FontAwesomeIcons.heart, titleKey: 'support', child: SupportWidget()),
];

class BottomNavItemViewHolder {

  final String titleKey;
  final IconData icon;
  final Widget child;

  const BottomNavItemViewHolder({required this.titleKey, required this.icon, required this.child});

}