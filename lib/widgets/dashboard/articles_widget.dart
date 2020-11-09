import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_blog_app_template/models/post.dart';
import 'package:wordpress_blog_app_template/rest/RestClient.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_progress_indicator.dart';

class ArticlesWidget extends StatelessWidget {

  const ArticlesWidget();

  @override
  Widget build(BuildContext context) {

    var restClient = context.watch<RestClient>();

    return FutureBuilder(
      future: restClient.fetchPosts(),
      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return WPProgressIndicator();
        }

        var posts = snapshot.data as List<Post>;

        return ListView.separated(
          itemCount: posts.length,
          itemBuilder: (context, index) => Text(posts[index].title),
          separatorBuilder: (context, index) => Divider(),
        );
      },
    );
  }
}