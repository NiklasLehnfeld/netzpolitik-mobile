import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_blog_app_template/models/article.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';
import 'package:wordpress_blog_app_template/routes/article_detail_route.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_card.dart';

class ArticleListEntry extends StatelessWidget {
  final Article article;
  final Function onTap;

  ArticleListEntry(this.article, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: WPCard(
        onTap: () => context.navigate((context) => ArticleDetailRoute(article)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(context),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_buildSubtitle(context), _buildTitle(context)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) => Hero(
        tag: 'article-title-${article.id}',
        child: Text(article.title,
            style: context.headline5.copyWith(color: Colors.black)),
      );

  Widget _buildSubtitle(BuildContext context) => Hero(
        tag: 'article-subtitle-${article.id}',
        child: Text(article.subTitle, style: context.headline6),
      );

  Widget _buildImage(BuildContext context) => Hero(
        tag: 'article-thumbnail-${article.id}',
        child: Image.network(article.imageUrl),
      );
}
