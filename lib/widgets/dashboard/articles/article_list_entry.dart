import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';
import 'package:wordpress_blog_app_template/models/article.dart';
import 'package:wordpress_blog_app_template/routes/article_detail_route.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/height.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_card.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/articles/article_image.dart';

class ArticleListEntry extends StatelessWidget {
  final Article article;
  final bool isBig;

  ArticleListEntry(this.article, {this.isBig});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: WPCard(
        onTap: () => context.navigate((context) => ArticleDetailRoute(article, isBig: isBig,)),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (context.isWide) {
      return _buildHorizontalContent(context);
    } else {
      return _buildVerticalContent(context);
    }
  }

  Widget _buildHorizontalContent(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: ArticleImage(article)),
          Expanded(child: _buildInfoSection(context)),
        ],
      );

  Widget _buildInfoSection(BuildContext context) => AspectRatio(
        aspectRatio: ArticleImage.IMAGE_ASPECT_RATIO,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubtitle(context),
              _buildTitle(context),
              Height(8),
              _buildSummary(context),
            ],
          ),
        ),
      );

  Widget _buildVerticalContent(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ArticleImage(article),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSubtitle(context),
                _buildTitle(context),
              ],
            ),
          ),
        ],
      );

  TextStyle getTitleStyle(BuildContext context) => isBig ? context.headline1 : context.headline5;
  TextStyle getSubtitleStyle(BuildContext context) => isBig ? context.headline2 : context.headline6;
  TextStyle getSummaryStyle(BuildContext context) => isBig ? context.headline4 : context.body2;

  Widget _buildTitle(BuildContext context) => Hero(
        tag: 'article-title-${article.id}',
        child: Text(article.title,
            style: getTitleStyle(context).copyWith(color: Colors.black)),
      );

  Widget _buildSubtitle(BuildContext context) => Hero(
        tag: 'article-subtitle-${article.id}',
        child: Text(article.subTitle, style: getSubtitleStyle(context).copyWith( color: context.primaryColor )),
      );

  Widget _buildSummary(BuildContext context) => Expanded(
        child: Hero(
          tag: 'article-summary-${article.id}',
          child: Text(
            article.summaryWithoutTags,
            overflow: TextOverflow.fade,
            style: getSummaryStyle(context).copyWith(color: Colors.black, fontWeight: FontWeight.normal),
          ),
        ),
      );


}
