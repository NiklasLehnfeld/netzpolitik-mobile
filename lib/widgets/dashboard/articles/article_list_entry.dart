import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_blog_app_template/models/article.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';

class ArticleListEntry extends StatelessWidget {

  final Article article;

  ArticleListEntry(this.article);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 8.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(article.imageUrl),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(article.subTitle, style: context.headline2),
                  Text(article.title, style: context.headline1.copyWith( color: Colors.black ),)
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}