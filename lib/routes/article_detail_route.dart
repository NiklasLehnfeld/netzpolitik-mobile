import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';
import 'package:wordpress_blog_app_template/extensions/int_ext.dart';
import 'package:wordpress_blog_app_template/extensions/string_ext.dart';
import 'package:wordpress_blog_app_template/models/article.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_article_appbar.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_html.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_play_button.dart';

class ArticleDetailRoute extends StatefulWidget {
  final Article article;

  ArticleDetailRoute(this.article);

  @override
  _ArticleDetailRouteState createState() => _ArticleDetailRouteState();
}

class _ArticleDetailRouteState extends State<ArticleDetailRoute> {
  bool hasMp3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WPArticleAppBar(widget.article),
            _buildSummaryArea(context),
            _buildImage(context),
            _buildContentArea(context)
          ],
        ),
      ),
    );
  }

  String get creationDate =>
      '${creation.day.zeroFill(2)}.${creation.month.zeroFill(2)}.${creation.year.zeroFill(4)} um ${creation.hour.zeroFill(2)}:${creation.minute.zeroFill(2)} Uhr';

  DateTime get creation => widget.article.creationTime;

  Widget _buildContentArea(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: WPHtml(widget.article.content),
      );

  Widget _buildSummaryArea(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubtitle(context),
            _buildTitle(context),
            WPHtml(widget.article.summary),
            Text(
                '$creationDate - $authorNames - in $categoryName - $numberOfReplies ${context.getString('replies')}',
                style: context.body2.copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: 12)
          ],
        ),
      );

  String get authorNames =>
      widget.article.authors.map((a) => a.name).join(', ');

  String get categoryName => widget.article.categories.first.name;

  int get numberOfReplies => widget.article.replies.length;

  Widget _buildTitle(BuildContext context) => Text(
        widget.article.title,
        style: context.headline1.copyWith(color: Colors.black),
      );

  Widget _buildSubtitle(BuildContext context) =>
      Text(widget.article.subTitle, style: context.headline2);

  Widget _buildImage(BuildContext context) => Stack(
        alignment: Alignment.bottomRight,
        children: [
          Image.network(
            widget.article.imageUrl,
            fit: BoxFit.fitWidth,
            width: context.width,
          ),
          Visibility(
            visible: widget.article.content.containsMP3,
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: WPPlayButton(url: widget.article.content.mp3Url),
            ),
          )
        ],
      );
}
