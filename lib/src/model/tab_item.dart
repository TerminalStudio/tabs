import 'package:flex_tabs/src/model/document.dart';
import 'package:flex_tabs/src/model/utils/disposable.dart';
import 'package:flutter/widgets.dart';
import 'package:flex_tabs/src/model/node.dart';
import 'package:flex_tabs/src/model/tabs.dart';

/// Represents a tab in a tab group.
class TabItem with TabsNode, Disposable {
  TabItem({Widget? title, Widget? content}) {
    this.title.value = title;
    this.content.value = content;
  }

  @override
  // ignore: overridden_fields
  covariant Tabs? parent;

  /// The title of this tab. Displayed in the tab bar.
  final title = ValueNotifier<Widget?>(null);

  /// The content of this tab. Displayed in the tab content area.
  final content = ValueNotifier<Widget?>(null);

  /// Replace this tab with [tab]. This is a shortcut for calling [Tabs.replace].
  /// If this tab is not in a [Tabs] container, this method does nothing.
  void replace(TabItem tab) {
    parent?.replace(this, tab);
  }

  /// Make this tab the actived tab in the parent tab group. This is a shortcut
  /// for calling [Tabs.activate]. If this tab is not in a [Tabs] container, this
  /// method does nothing.
  void activate() {
    parent?.activate(this);
  }

  /// Remove this tab from the parent tab group. This is a shortcut for calling
  /// [Tabs.remove]. If this tab is not in a [Tabs] container, this method does
  /// nothing.
  void detach() {
    parent?.remove(this);
  }

  /// Make this tab permanently closed. After this method is called, this tab
  /// will be removed from the parent tab group and can not be re-added to tab
  /// groups.
  @override
  void dispose() {
    detach();

    super.dispose();

    didDispose();
  }

  /// Returns true if this tab is the actived tab in the parent tab group.
  bool get isActivated {
    if (parent == null) {
      return false;
    }

    return parent!.activeTab == this;
  }

  /// Function called when the tab is attached to a [TabsDocument].
  void didMount() {}

  /// Function called when the tab is removed from a [TabsDocument].
  void didUnmount() {}

  /// Function called when the tab is activated.
  void didActivate() {}

  /// Function called when the tab is deactivated.
  void didDeactivate() {}

  /// Function called when the tab is permanently closed.
  void didDispose() {}

  @override
  String toString() => 'Tab<${title.value}>';
}
