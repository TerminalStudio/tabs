// ignore_for_file: avoid_renaming_method_parameters

import 'package:flex_tabs/src/model/container.dart';
import 'package:flex_tabs/src/model/document.dart';
import 'package:flex_tabs/src/model/layout.dart';
import 'package:flex_tabs/src/model/tab_item.dart';

class Tabs extends TabsContainer<TabItem> {
  Tabs({List<TabItem>? children}) : super(children) {
    if (children != null) {
      _activeTab = children.first;
    }
  }

  TabItem? _activeTab;

  TabItem? get activeTab => _activeTab;

  final _activeHistory = <TabItem>[];

  TabItem? _findLastActiveTab() {
    if (_activeHistory.isEmpty) {
      return null;
    }

    while (_activeHistory.length > 1) {
      final tab = _activeHistory.removeLast();
      if (children.contains(tab)) {
        return tab;
      }
    }

    return null;
  }

  @override
  void add(TabItem node) {
    super.add(node);

    if (activeTab == null) {
      activate(node);
    }
  }

  void activate(TabItem? tab) {
    if (_activeTab == tab) {
      return;
    }

    if (children.contains(tab)) {
      _activeTab = tab;
      _activeHistory.add(tab!);
      notifyListeners();
    }
  }

  @override
  bool remove(TabItem tab) {
    if (!super.remove(tab)) {
      return false;
    }

    if (children.isEmpty) {
      final parent = this.parent;
      if (parent is TabsLayout && parent is! TabsDocument) {
        parent.remove(this);
      }
    }

    if (children.isNotEmpty && tab == _activeTab) {
      _activeTab = _findLastActiveTab() ?? children.last;
      notifyListeners();
    }

    return true;
  }

  @override
  String toString() => 'Tabs[${children.join(', ')}]';
}
