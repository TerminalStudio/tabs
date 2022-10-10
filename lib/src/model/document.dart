import 'package:flex_tabs/src/model/container.dart';
import 'package:flex_tabs/src/model/tab_item.dart';
import 'package:flutter/widgets.dart';

/// The root of the tabs tree. Can hold a single [TabsContainer] as the root
/// node.
class TabsDocument extends TabsContainer<TabsContainer> {
  TabsContainer? get root => children.isNotEmpty ? children.first : null;

  /// Sets the root node of the tabs tree to [root].
  void setRoot(TabsContainer? root) {
    removeAll();
    if (root != null) {
      add(root);
    }
  }

  /// The last actived tab in the entire tabs tree.
  final activeTab = ValueNotifier<TabItem?>(null);
}
