import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_back_button.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_html.dart';

class ImprintRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: WPBackButton(),
          title: Text(
            context.getString('imprint_headline'),
            style: context.headline1.copyWith( color: context.primaryColor ),
          ),
        ),
        body: _buildContent(context));
  }

  Widget _buildContent(BuildContext context) {
    return Center(child: WPHtml(context.getString('imprint_content')));
  }
}
