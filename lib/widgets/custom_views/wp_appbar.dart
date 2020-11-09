import 'package:flutter/material.dart';

class WPAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;

  WPAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;

}