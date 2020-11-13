import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paging/paging.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';

const ERROR_ICON_SIZE = 70.0;
const LIST_ITEM_SPACING = 15.0;

class WPPagedList<T> extends StatefulWidget {

  final Function(int) pageBuilder;
  final Function(T) itemBuilder;
  final String errorMessage;

  const WPPagedList({this.pageBuilder, this.itemBuilder, this.errorMessage = 'Error'});

  @override
  _WPPagedListState createState() => _WPPagedListState<T>();
}

class _WPPagedListState<T> extends State<WPPagedList<T>> {
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isError,
      child: _buildActualList(context),
      replacement: _buildErrorWidget(context),
    );
  }

  Widget _buildActualList(BuildContext context) => Pagination<T>(
    pageBuilder: widget.pageBuilder,
    itemBuilder: (index, article) => Container(
      child: widget.itemBuilder(article),
      margin: EdgeInsets.only(bottom: LIST_ITEM_SPACING),
    ),
    onError: (_) => setState(() => isError = true),
  );


  Widget _buildErrorWidget(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          IconButton(
            iconSize: ERROR_ICON_SIZE,
            icon: FaIcon(
              FontAwesomeIcons.syncAlt,
              color: context.primaryColor,
            ),
            onPressed: () => setState(() => isError = false),
          ),
          Container(
            width: 300,
            child: Text(
              widget.errorMessage,
              style: context.headline6,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    ),
  );
}