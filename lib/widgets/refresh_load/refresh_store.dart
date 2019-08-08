/**
 * 统一管理refresh widget中的数据
 * contextAPI
 */
import 'package:flutter/material.dart';

class RefreshStore extends InheritedWidget {
  RefreshStore({
    Key key,
    Widget child,
    @required this.state,
  }) : super(key: key, child: child);

  final Map state;

  static RefreshStore of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(RefreshStore);
  }

  @override
  bool updateShouldNotify(RefreshStore oldWidget) {
    return oldWidget.state != state;
  }
}
