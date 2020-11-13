import 'package:flutter/cupertino.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';
import 'package:wordpress_blog_app_template/models/author.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_html.dart';


class AuthorListEntry extends StatelessWidget {

  final Author author;

  const AuthorListEntry(this.author);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2.0, bottom: 8),
          child: Text(author.name, style: context.headline6.copyWith( fontSize: 20),),
        ),
        WPHtml(author.description, style: context.body1,)
      ],
    );
  }

}