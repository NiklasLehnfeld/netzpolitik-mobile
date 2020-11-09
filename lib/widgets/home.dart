import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_appbar.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_bottom_navigation_bar.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/articles_widget.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/settings_widget.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/topics_widget.dart';


class Home extends StatefulWidget {

  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _children = [
    BottomNavItemViewHolder(icon: FontAwesomeIcons.newspaper, titleKey: 'articles', child: ArticlesWidget(), selected: true),
    BottomNavItemViewHolder(icon: FontAwesomeIcons.stream, titleKey: 'topics', child: TopicsWidget()),
    BottomNavItemViewHolder(icon: FontAwesomeIcons.tools, titleKey: 'settings', child: SettingsWidget()),
  ];

  WPBottomNavigationBar bottomNavigationBar;

  @override
  void initState() {
    bottomNavigationBar = WPBottomNavigationBar(
      children: _children,
      onTabChanged: (child) => setState(() {}),
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WPAppBar(widget.title),
      bottomNavigationBar: bottomNavigationBar,
      body: bottomNavigationBar.currentItem.child
    );
  }
}
