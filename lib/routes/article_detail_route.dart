import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wordpress_blog_app_template/models/article.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';
import 'package:wordpress_blog_app_template/extensions/int_ext.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_back_button.dart';

class ArticleDetailRoute extends StatelessWidget {
  final Article article;

  ArticleDetailRoute(this.article);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummaryArea(context),
                  _buildImage(context),
                  _buildContentArea(context)
                ],
              ),
              WPBackButton()
            ],
          ),
        ),
      ),
    );
  }

  String get creationDate =>
      '${creation.day.zeroFill(2)}.${creation.month.zeroFill(2)}.${creation.year.zeroFill(4)} um ${creation.hour.zeroFill(2)}:${creation.minute.zeroFill(2)} Uhr';

  DateTime get creation => article.creationTime;

  Widget _buildContentArea(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Html(data: article.content),
  );

  Widget _buildSummaryArea(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            _buildSubtitle(context),
            _buildTitle(context),
            Html(data: article.summary),
            Row(
              children: [
                Text(creationDate, style: context.body2.copyWith( fontWeight: FontWeight.bold)),
                Text(' - ', style: context.body2.copyWith( fontWeight: FontWeight.bold)),
                Text(article.author.name, style: context.body2.copyWith( fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(height: 12)
          ],
        ),
      );


  Widget _buildTitle(BuildContext context) => Hero(
        tag: 'article-title-${article.id}',
        child: Text(
          article.title,
          style: context.headline1.copyWith(color: Colors.black),
        ),
      );

  Widget _buildSubtitle(BuildContext context) => Hero(
        tag: 'article-subtitle-${article.id}',
        child: Text(article.subTitle, style: context.headline2),
      );

  Widget _buildImage(BuildContext context) => Hero(
        tag: 'article-thumbnail-${article.id}',
        child: Image.network(
          article.imageUrl,
          fit: BoxFit.fitWidth,
          width: context.width,
        ),
      );
}
