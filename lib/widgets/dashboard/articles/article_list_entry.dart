import 'package:flutter/material.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/models/article.dart';
import 'package:netzpolitik_mobile/routes/article_detail_route.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/bookmark_button.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/height.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/share_button.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/width.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_card.dart';
import 'package:netzpolitik_mobile/widgets/dashboard/articles/article_image.dart';

class ArticleListEntry extends StatelessWidget {
  final Article article;
  final bool isBig;
  final String? identifier;

  ArticleListEntry(this.article, {required this.isBig, this.identifier});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: WPCard(
        onTap: () => context.navigate((context) => ArticleDetailRoute(article,
            isBig: isBig, identifier: _identifier())),
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
          Expanded(child: ArticleImage(article, identifier: _identifier())),
          Expanded(child: _buildInfoSection(context)),
        ],
      );

  Widget _buildInfoSection(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubtitle(context),
            _buildTitle(context),
            Height(8),
            _buildSummary(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMetaData(context),
                Row(
                  children: [
                    ShareButtonWidget(article,
                      hasPadding: false,
                      color: Colors.blue[200],
                    ),
                    Width(12),
                    BookmarkButtonWidget(article,
                      hasPadding: false,
                      color: Colors.blue[200],
                    )
                  ],
                )

              ],
            )
          ],
        ),
      );

  Widget _buildVerticalContent(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ArticleImage(article, identifier: _identifier()),
          _buildInfoSection(context),
        ],
      );

  TextStyle getTitleStyle(BuildContext context) =>
      isBig ? context.headline1 : context.headline5;

  TextStyle getSubtitleStyle(BuildContext context) => isBig
      ? context.body1
      : context.body2.copyWith(fontWeight: FontWeight.bold);

  TextStyle getSummaryStyle(BuildContext context) =>
      isBig ? context.headline4 : context.body2;

  TextStyle getCaptionStyle(BuildContext context) => context.caption;

  Widget _buildTitle(BuildContext context) => Hero(
        tag: 'article-title-${_identifier()}-${article.id}',
        child: Text(article.title ?? '',
            style: getTitleStyle(context)),
      );

  Widget _buildSubtitle(BuildContext context) => Hero(
        tag: 'article-subtitle-${_identifier()}-${article.id}',
        child: Text(article.subTitle ?? '',
            style: getSubtitleStyle(context)),
      );

  Widget _buildSummary(BuildContext context) => Hero(
        tag: 'article-summary-${_identifier()}-${article.id}',
        child: Text(
          article.summaryWithoutTags ?? '',
          overflow: TextOverflow.fade,
          style: getSummaryStyle(context)
              .copyWith(fontWeight: FontWeight.normal),
        ),
      );

  Widget _buildMetaData(BuildContext context) => Hero(
        tag: 'article-metadata-${_identifier()}-${article.id}',
        child: Text(
          getMetaData(context),
          overflow: TextOverflow.fade,
          style: getCaptionStyle(context),
        ),
      );

  String getAuthors(BuildContext context) {
    if (article.authors == null) {
      return context.getString('unknown_author');
    }

    return article.authors!.map((e) => e.name).join(', ');
  }

  String getMetaData(BuildContext context) =>
      getAuthors(context) +
      ' | ' +
      (article.replies ?? []).length.toString() +
      ' ' +
      context.getString('replies');

  String _identifier() => identifier ?? 'default';
}
