import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netzpolitik_mobile/config/rest_configuration.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/extensions/article_ext.dart';
import 'package:netzpolitik_mobile/models/article.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_audio_player.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_html.dart';
import 'package:provider/provider.dart';

class ArticleImage extends StatelessWidget {
  static const IMAGE_ASPECT_RATIO = 1.77;

  final Article article;
  final String identifier;
  final bool captionVisible;
  final bool showAudioPlayer;

  const ArticleImage(this.article,
      {required this.identifier,
        this.captionVisible = false,
        this.showAudioPlayer = true
      });

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
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      _buildProgressIndicator(downloadProgress.progress ?? 0),
                  errorWidget: (context, url, error) => _buildErrorWidget(context),
                  fit: BoxFit.cover,
                ),
                Visibility(
                  visible: showAudioPlayer && article.hasMp3,
                  child: WPAudioPlayer(
                    article: article,
                    alwaysVisible: true,
                    showTitleSection: false,
                    backgroundAlpha: 200,
                    showCross: false,
                  ),
                )
              ],
            ),
          ),
        ),
        Visibility(
          visible: showCaption,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: WPHtml(
              showCaption ? '${article.imageCaption?.replaceAll(RegExp('</?p>'), '')} ${article.imageLicenceCaption}' : '',
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
