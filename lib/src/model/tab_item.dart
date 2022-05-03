import 'package:flutter/widgets.dart';
import 'package:flex_tabs/src/model/node.dart';
import 'package:flex_tabs/src/model/tabs.dart';

class TabItem with TabsNode {
  TabItem({Widget? title, Widget? content}) {
    this.title.value = title;
    this.content.value = content;
  }

  @override
  // ignore: overridden_fields
  covariant Tabs? parent;

  final title = ValueNotifier<Widget?>(null);

  final content = ValueNotifier<Widget?>(null);

  void insertBefore(TabItem tab) {
    final parent = this.parent;

    if (parent == null) {
      return;
    }

    final index = parent.indexOf(this);

    parent.insert(index, tab);
  }

  void replace(TabItem tab) {
    final isActivated = this.isActivated;

    if (parent != null) {
      parent!.replace(this, tab);
    }

    if (isActivated) {
      tab.activate();
    }
  }

  void detach() {
    if (parent != null) {
      parent!.remove(this);
    }
  }

  void activate() {
    if (parent != null) {
      parent!.activate(this);
    }
  }

  bool get isActivated {
    if (parent == null) {
      return false;
    }

    return parent!.activeTab == this;
  }

  @override
  String toString() => 'Tab<${title.value}>';
}
