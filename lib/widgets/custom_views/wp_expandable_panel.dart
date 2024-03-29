import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_card.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_html.dart';

const PREVIEW_LENGTH = 100;
const INNER_PADDING = 8.0;

class WPExpandablePanel extends StatefulWidget {
  final String title;
  final String body;

  WPExpandablePanel({required this.title, required this.body});

  @override
  _WPExpandablePanelState createState() => _WPExpandablePanelState();
}

class _WPExpandablePanelState extends State<WPExpandablePanel> {
  late ExpandableController _controller;

  @override
  void initState() {
    _controller = ExpandableController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WPCard(
      padding: EdgeInsets.all(INNER_PADDING),
      child: ExpandablePanel(
        controller: _controller,
        header: Container(
          margin: EdgeInsets.only(top: INNER_PADDING),
          child: Text(
            widget.title,
            style: context.headline2,
          ),
        ),
        collapsed: InkWell(
          child: WPHtml('${widget.body.substring(0, PREVIEW_LENGTH)}...'),
          onTap: () => _controller.toggle(),
        ),
        expanded: WPHtml(widget.body),
      ),
    );
  }
}
