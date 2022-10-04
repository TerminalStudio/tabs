import 'package:flex_tabs/src/model/container.dart';
import 'package:flex_tabs/src/model/tab_item.dart';
import 'package:flutter/widgets.dart';

class TabsDocument extends TabsContainer<TabsContainer> {
  TabsContainer? get root => children.isNotEmpty ? children.first : null;

  void setRoot(TabsContainer? root) {
    removeAll();
    if (root != null) {
      add(root);
    }
  }

  final focusedTab = ValueNotifier<TabItem?>(null);
}
