import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_blog_app_template/config/app_configuration.dart';

class WPAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {

    var appConfig = context.watch<AppConfiguration>();

    return AppBar(
      backgroundColor: Colors.white,
      title: Center(child: appConfig.title ?? Text(appConfig.name),),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;

}