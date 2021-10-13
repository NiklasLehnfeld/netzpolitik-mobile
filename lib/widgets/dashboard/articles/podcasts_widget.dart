import 'package:flutter/material.dart';
import 'package:netzpolitik_mobile/models/category.dart';
import 'package:netzpolitik_mobile/widgets/dashboard/articles/articles_list.dart';

class PodcastsWidget extends StatelessWidget {

  const PodcastsWidget();

  @override
  Widget build(BuildContext context) => ArticlesList(
      categoryFilter: Category.withId(38),
    identifier: 'podcasts',
  );

}