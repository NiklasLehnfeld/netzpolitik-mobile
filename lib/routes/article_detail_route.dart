import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/extensions/int_ext.dart';
import 'package:netzpolitik_mobile/extensions/string_ext.dart';
import 'package:netzpolitik_mobile/models/article.dart';
import 'package:netzpolitik_mobile/models/audio_model.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_article_appbar.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_html.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_play_button.dart';
import 'package:netzpolitik_mobile/widgets/dashboard/articles/article_image.dart';

class ArticleDetailRoute extends StatefulWidget {
  final Article article;
  final bool isBig;
  final String identifier;

  ArticleDetailRoute(this.article, {this.isBig, this.identifier});

  @override
  _ArticleDetailRouteState createState() => _ArticleDetailRouteState();
}

class _ArticleDetailRouteState extends State<ArticleDetailRoute> {
  bool hasMp3 = false;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        Widget topArea;

        if (context.isUltraWide ||
            (context.isWide && orientation == Orientation.landscape)) {
          topArea =
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: _buildImage(context)),
            Expanded(child: _buildSummaryArea(context))
          ]);
        } else {
          topArea = Column(
              children: [_buildSummaryArea(context), _buildImage(context)]);
        }

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WPArticleAppBar(widget.article),
                topArea,
                _buildContentArea(context)
              ],
            ),
          ),
        );
      },
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
            _buildSummary(context),
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

  Widget _buildSummary(BuildContext context) => Hero(
        tag: 'article-summary-${widget.identifier}-${widget.article.id}',
        child: Text(
          widget.article.summaryWithoutTags,
          style: getSummaryStyle(context)
              .copyWith(color: Colors.black, fontWeight: FontWeight.normal),
        ),
      );

  Widget _buildTitle(BuildContext context) => Hero(
        tag: 'article-title-${widget.identifier}-${widget.article.id}',
        child: Text(widget.article.title,
            style: getTitleStyle(context).copyWith(color: Colors.black)),
      );

  Widget _buildSubtitle(BuildContext context) => Hero(
        tag: 'article-subtitle-${widget.identifier}-${widget.article.id}',
        child: Text(widget.article.subTitle,
            style: getSubtitleStyle(context)
                .copyWith(color: context.primaryColor)),
      );

  Widget _buildImage(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ArticleImage(
          widget.article,
          identifier: widget.identifier,
          captionVisible: true,
        ),
        Visibility(
          visible: widget.article.content.containsMP3,
          child: Container(
            margin: EdgeInsets.only(right: 10),
            child: WPPlayButton(
              audio: AudioModel(
                  title: widget.article.title,
                  url: widget.article.content.mp3Url),
            ),
          ),
        )
      ],
    );
  }

  TextStyle getTitleStyle(BuildContext context) =>
      widget.isBig ? context.headline1 : context.headline5;

  TextStyle getSubtitleStyle(BuildContext context) =>
      widget.isBig ? context.headline2 : context.headline6;

  TextStyle getSummaryStyle(BuildContext context) =>
      widget.isBig ? context.headline4 : context.body2;
}
