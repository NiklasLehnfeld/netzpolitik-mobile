import 'package:flutter/cupertino.dart';
import 'package:wordpress_blog_app_template/models/author.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_bottom_sheet.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/articles/author_list_entry.dart';

class AuthorBottomSheet extends StatelessWidget {

  final List<Author> authors;

  AuthorBottomSheet(this.authors);

  @override
  Widget build(BuildContext context) {

    return WPBottomSheet(
        child: Column(
          children: authors.map((e) => AuthorListEntry(e)).toList(),
        ),
    );
  }
}

