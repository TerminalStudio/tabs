import 'package:flutter/widgets.dart';
import 'package:flex_tabs/src/model/document.dart';
import 'package:flex_tabs/src/model/tab_item.dart';
import 'package:flex_tabs/src/model/tabs.dart';

class TabScope extends InheritedWidget {
  const TabScope(this.tab, {Key? key, required Widget child})
      : super(key: key, child: child);

  static TabItem? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TabScope>()?.tab;

  final TabItem tab;

  @override
  bool updateShouldNotify(covariant TabScope oldWidget) {
    return oldWidget.tab != tab;
  }
}

class TabsScope extends InheritedWidget {
  const TabsScope(this.tabs, {Key? key, required Widget child})
      : super(key: key, child: child);

  static Tabs? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TabsScope>()?.tabs;

  final Tabs tabs;

  @override
  bool updateShouldNotify(covariant TabsScope oldWidget) {
    return oldWidget.tabs != tabs;
  }
}

class TabsDocumentScope extends InheritedWidget {
  const TabsDocumentScope(this.document, {Key? key, required Widget child})
      : super(key: key, child: child);

  static TabsDocument? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TabsDocumentScope>()?.document;

  final TabsDocument document;

  @override
  bool updateShouldNotify(covariant TabsDocumentScope oldWidget) {
    return oldWidget.document != document;
  }
}
