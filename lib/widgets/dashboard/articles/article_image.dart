import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_blog_app_template/config/rest_configuration.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';
import 'package:wordpress_blog_app_template/models/article.dart';


const IMAGE_ASPECT_RATIO = 1.77;

class ArticleImage extends StatelessWidget {
  final Article article;

  const ArticleImage(this.article);

  @override
  Widget build(BuildContext context) {
    var restConfig = context.watch<RestConfiguration>();
    var imageUrl = '${restConfig.imageBaseUrl}/${article.imageName}';

    return Hero(
      tag: 'article-thumbnail-${article.id}',
      child: AspectRatio(
        aspectRatio: IMAGE_ASPECT_RATIO,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              _buildProgressIndicator(downloadProgress.progress),
          errorWidget: (context, url, error) => _buildErrorWidget(context),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context) => Icon(Icons.error_outline, color: context.primaryColor, size: 40,);

  Widget _buildProgressIndicator(double progress) => AspectRatio(
    aspectRatio: IMAGE_ASPECT_RATIO,
    child: Center(
      child: Wrap(
        children: [
          SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  value: progress,
                ),
              ),
        ],
      ),
    ),
  );
}