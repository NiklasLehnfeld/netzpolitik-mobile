import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';

class WPBottomNavigationBar extends StatefulWidget {

  final List<BottomNavItemViewHolder> children;
  final Function(BottomNavItemViewHolder) onTabChanged;
  
  int get currentIndex => children.indexWhere((viewHolder) => viewHolder.selected == true);
  BottomNavItemViewHolder get currentItem => children[currentIndex];


  WPBottomNavigationBar({@required this.children, this.onTabChanged});

  @override
  _WPBottomNavigationBarState createState() => _WPBottomNavigationBarState();

}

class _WPBottomNavigationBarState extends State<WPBottomNavigationBar> {
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showUnselectedLabels: false,
      currentIndex: widget.currentIndex,
      items: widget.children.map((viewHolder) => BottomNavigationBarItem(
        label: context.getString(viewHolder.titleKey),
        icon: FaIcon(viewHolder.icon)
      )).toList(),
      onTap: (index) => setState(() => onTapped(index))
    );
  }

  void onTapped(int index) => setState(() {
    widget.children.where((viewHolder) => viewHolder.selected).forEach((viewHolder) => viewHolder.selected = false);
    widget.children[index].selected = true;
    if (widget.onTabChanged != null) {
      widget.onTabChanged(widget.children[index]);
    }
  });

}

class BottomNavItemViewHolder {

  final String titleKey;
  final IconData icon;
  final Widget child;
  bool selected;

  BottomNavItemViewHolder({this.titleKey, this.icon, this.child, this.selected = false});

}