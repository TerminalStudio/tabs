// ignore_for_file: avoid_renaming_method_parameters

import 'package:flex_tabs/src/model/container.dart';
import 'package:flex_tabs/src/model/document.dart';
import 'package:flex_tabs/src/model/layout.dart';
import 'package:flex_tabs/src/model/tab_item.dart';

class Tabs extends TabsContainer<TabItem> {
  Tabs({List<TabItem>? children}) : super(children) {
    for (final child in children ?? []) {
      add(child);
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
    if (node.disposed) {
      throw StateError('Disposed tab cannot be added to tabs.');
    }

    super.add(node);

    node.didMount();

    if (activeTab == null) {
      activate(node);
    }
  }

  void activate(TabItem? tab) {
    if (!children.contains(tab)) {
      return;
    }

    if (_activeTab != tab) {
      _activeTab?.didDeactivate();

      _activeTab = tab;

      _activeHistory.add(tab!);

      tab.didActivate();

      notifyListeners();
    }

    document?.activeTab.value = tab;
  }

  @override
  void replace(TabItem oldNode, TabItem newNode) {
    final isActive = _activeTab == oldNode;

    super.replace(oldNode, newNode);

    if (isActive) {
      activate(newNode);
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
      final activeTab = _findLastActiveTab() ?? children.last;
      activate(activeTab);
    }

    tab.didUnmount();

    return true;
  }

  @override
  String toString() => 'Tabs[${children.join(', ')}]';
}
