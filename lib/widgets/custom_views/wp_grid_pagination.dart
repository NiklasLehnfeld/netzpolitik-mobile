library paging;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_error_widget.dart';

typedef PaginationBuilder<T> = Future<List<T>> Function(int currentListSize);

typedef ItemWidgetBuilder<T> = Widget Function(int index, T item, bool isBig);


const VERTICAL_LIST_ITEM_SPACING = 15.0;
const HORIZONTAL_LIST_ITEM_SPACING = 5.0;

class WPGridPagination<T> extends StatefulWidget {
  WPGridPagination({
    Key key,
    @required this.pageBuilder,
    @required this.itemBuilder,
    this.enableSingleTop = true,
    this.errorLabel,
  })  : assert(pageBuilder != null),
        assert(itemBuilder != null),
        super(key: key);

  final PaginationBuilder<T> pageBuilder;
  final ItemWidgetBuilder<T> itemBuilder;
  final String errorLabel;
  final bool enableSingleTop;

  @override
  _WPGridPaginationState<T> createState() => _WPGridPaginationState<T>();
}

class _WPGridPaginationState<T> extends State<WPGridPagination<T>> {
  final List<T> _list = [];
  bool _isLoading = false;
  bool _isError = false;
  bool _isEndOfList = false;

  void fetchMore() {
    if (!_isLoading) {
      _isLoading = true;
      widget.pageBuilder(_list.length).then((list) {
        _isLoading = false;
        if (list.isEmpty) {
          _isEndOfList = true;
        }
        setState(() {
          _list.addAll(list);
        });
      }).catchError((error) {
        setState(() {
          _isEndOfList = true;
          _isError = true;
        });
        print(error);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMore();
  }

  @override
  Widget build(BuildContext context) {
    if (_isError) {
      return errorWidget(context);
    }

    if (_list.isEmpty) {
      return defaultLoading();
    }

    var colCount = context.isUltraWide ? 2 : 1;

    return StaggeredGridView.countBuilder(
        crossAxisCount: colCount,
        itemCount: _list.length + 1,
        mainAxisSpacing: VERTICAL_LIST_ITEM_SPACING,
        crossAxisSpacing: HORIZONTAL_LIST_ITEM_SPACING,
        itemBuilder: (BuildContext context, int position) {
          if (position < _list.length) {
            return widget.itemBuilder(position, _list[position], false);
          } else if (position == _list.length && !_isEndOfList) {
            fetchMore();
            return defaultLoading();
          }
          return Container();
        },
        staggeredTileBuilder: (int index) {

          if (widget.enableSingleTop && index == 0 && context.isWide) {
            return StaggeredTile.fit(colCount);
          }

          if (index == _list.length) {
            return StaggeredTile.extent(colCount, 40);
          }

          return StaggeredTile.fit(1);
        }
    );
  }

  Widget defaultLoading() {
    return Align(
      child: SizedBox(
        height: 40,
        width: 40,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget errorWidget(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: WPErrorWidget(
            text: widget.errorLabel,
            onPress: () {
              setState(() => _isError = false);
              fetchMore();
            },
          )
        ),
      );
}
