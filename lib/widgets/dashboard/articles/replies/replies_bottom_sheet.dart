import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';
import 'package:wordpress_blog_app_template/models/reply.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_bottom_sheet.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/articles/replies/reply_list_entry.dart';

class RepliesBottomSheet extends StatelessWidget {

  final List<Reply> replies;

  const RepliesBottomSheet(this.replies);

  @override
  Widget build(BuildContext context) {
    var topLevelReplies = replies.where((reply) => reply.parent == 0).toList();

    topLevelReplies.sort(
          (a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)),
    );

    return WPBottomSheet(
        fixedHeight: context.height * 0.6,
        child: ListView.separated(
          itemCount: topLevelReplies.length,
          itemBuilder: (context, index) => ReplyListEntry(topLevelReplies[index]),
          separatorBuilder: (context, index) => Divider(),
        )
    );
  }

}
