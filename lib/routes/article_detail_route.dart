import 'package:flutter/material.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/extensions/int_ext.dart';
import 'package:netzpolitik_mobile/extensions/article_ext.dart';
import 'package:netzpolitik_mobile/extensions/string_ext.dart';
import 'package:netzpolitik_mobile/logic/rating_manager.dart';
import 'package:netzpolitik_mobile/models/article.dart';
import 'package:netzpolitik_mobile/models/author.dart';
import 'package:netzpolitik_mobile/models/category.dart';
import 'package:netzpolitik_mobile/models/reply.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_article_appbar.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_audio_player.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_html.dart';
import 'package:netzpolitik_mobile/widgets/dashboard/articles/article_image.dart';
import 'package:provider/provider.dart';

class ArticleDetailRoute extends StatefulWidget {
  final Article article;
  final bool isBig;
  final String identifier;

  ArticleDetailRoute(this.article,
      {required this.isBig, required this.identifier});

  @override
  _ArticleDetailRouteState createState() => _ArticleDetailRouteState();
}

class _ArticleDetailRouteState extends State<ArticleDetailRoute> {
  @override
  void initState() {
    var ratingManager = context.read<RatingManager>();
    ratingManager.trackArticleRead();
    super.initState();
  }

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
        child: WPHtml((widget.article.content ?? '').withoutMp3),
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

  List<Author> get authors => widget.article.authors ?? [];

  List<Reply?> get replies => widget.article.replies ?? [];

  List<Category> get categories => widget.article.categories ?? [];

  String get authorNames => authors.map((a) => a.name).join(', ');

  String get categoryName => categories.first.name ?? '';

  int get numberOfReplies => replies.length;

  Widget _buildSummary(BuildContext context) => Hero(
        tag: 'article-summary-${widget.identifier}-${widget.article.id}',
        child: Text(
          widget.article.summaryWithoutTags ?? '',
          style: getSummaryStyle(context)
              .copyWith(color: Colors.black, fontWeight: FontWeight.normal),
        ),
      );

  Widget _buildTitle(BuildContext context) => Hero(
        tag: 'article-title-${widget.identifier}-${widget.article.id}',
        child: Text(widget.article.title ?? '',
            style: getTitleStyle(context).copyWith(color: Colors.black)),
      );

  Widget _buildSubtitle(BuildContext context) => Hero(
        tag: 'article-subtitle-${widget.identifier}-${widget.article.id}',
        child: Text(widget.article.subTitle ?? '',
            style: getSubtitleStyle(context)
                .copyWith(color: context.primaryColor)),
      );

  Widget _buildImage(BuildContext context) {
    return Column(
      children: [
        Visibility(
            visible: widget.article.hasMp3,
            child: Column(
              children: [
                Divider(
                  height: 1,
                ),
                WPAudioPlayer(
                  article: widget.article,
                  alwaysVisible: true,
                  showCross: false,
                ),
              ],
            )),
        ArticleImage(
          widget.article,
          identifier: widget.identifier,
          captionVisible: true,
          showAudioPlayer: false,
        ),
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
