import 'package:flex_tabs/src/ui/theme_data.dart';
import 'package:flutter/widgets.dart';

class TabsViewTheme extends InheritedWidget {
  const TabsViewTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final TabsViewThemeData data;

  static TabsViewThemeData of(BuildContext context) {
    final inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<TabsViewTheme>();
    return inheritedTheme?.data ?? const TabsViewThemeData();
  }

  @override
  bool updateShouldNotify(TabsViewTheme oldWidget) => data != oldWidget.data;
}
