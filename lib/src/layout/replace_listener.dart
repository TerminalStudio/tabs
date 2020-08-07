import 'package:flutter/widgets.dart';
import 'package:tabs/src/layout/tabs_layout.dart';

class ReplaceListener extends InheritedWidget {
  ReplaceListener({
    Key key,
    @required this.child,
    @required this.onReplace,
  }) : super(key: key, child: child);

  @override
  final Widget child;

  final void Function(TabsLayout) onReplace;

  static ReplaceListener of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ReplaceListener>());
  }

  void requestReplace(TabsLayout replacement) {
    // print('requestReplace $replacement');
    onReplace(replacement);
  }

  @override
  bool updateShouldNotify(ReplaceListener oldWidget) {
    return false;
  }
}
