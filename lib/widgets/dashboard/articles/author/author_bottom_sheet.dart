import 'package:flutter/cupertino.dart';
import 'package:netzpolitik_mobile/models/author.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_bottom_sheet.dart';
import 'package:netzpolitik_mobile/widgets/dashboard/articles/author/author_list_entry.dart';

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

