import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/models/reply.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/width.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_card.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_html.dart';

class ReplyListEntry extends StatelessWidget {
  final Reply reply;

  const ReplyListEntry(this.reply);

  @override
  Widget build(BuildContext context) {
    return _buildContent(context, reply);
  }

  Widget _buildContent(BuildContext context, Reply reply) {

    reply.replies.sort(
      (a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)),
    );

    return WPCard(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ExpandablePanel(
              header: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAuthorName(context, reply),
                    _buildTimestamp(context, reply),
                  ]),
              collapsed: WPHtml(reply.summary),
              expanded: WPHtml(reply.content),
            ),
            Column(
                children: reply.replies
                    .map((childReply) => Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: _buildContent(context, childReply),
                        ))
                    .toList())
          ],
        ),
      ),
    );
  }

  Widget _buildTimestamp(BuildContext context, Reply reply) {
    var dateFormat = DateFormat(
        "dd. MMMM yyyy '${context.getString('time_at')}' HH:mm '${context.getString('oclock')}'");
    var parsed = DateTime.parse(reply.date);

    return Text(dateFormat.format(parsed));
  }

  Widget _buildAuthorName(BuildContext context, Reply reply) => Row(
        children: [
          Text(reply.nameOrAnonymous,
              style: context.body1.copyWith(fontWeight: FontWeight.bold)),
          Width(2),
          Text(context.getString('reply_name_says'), style: context.body1)
        ],
      );
}

extension on Reply {
  String get summary =>
      content.length <= 150 ? content : content.substring(0, 150) + '...';

  String get nameOrAnonymous =>
      authorName != null && authorName.isNotEmpty ? authorName : 'Anonymous';
}
