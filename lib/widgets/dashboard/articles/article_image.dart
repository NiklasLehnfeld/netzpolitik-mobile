import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netzpolitik_mobile/config/rest_configuration.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/models/article.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_html.dart';
import 'package:provider/provider.dart';

class ArticleImage extends StatelessWidget {
  static const IMAGE_ASPECT_RATIO = 1.77;

  final Article article;
  final String identifier;
  final bool captionVisible;

  const ArticleImage(this.article,
      {this.identifier, this.captionVisible = false});

  @override
  Widget build(BuildContext context) {
    var restConfig = context.watch<RestConfiguration>();
    var imageUrl = '${restConfig.imageBaseUrl}/${article.imageName}';

    var showCaption = captionVisible && article.imageCaption != null;

    return Column(
      children: [
        Hero(
          tag: 'article-thumbnail-$identifier-${article.id}',
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
        ),
        Visibility(
          visible: showCaption,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: WPHtml(
              showCaption ? '${article.imageCaption.replaceAll(RegExp('</?p>'), '')} ${article.imageLicenceCaption}' : '',
              style: context.caption,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildErrorWidget(BuildContext context) => Icon(
        Icons.error_outline,
        color: context.primaryColor,
        size: 40,
      );

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
