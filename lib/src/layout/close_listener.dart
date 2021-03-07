import 'package:flutter/widgets.dart';
import 'package:tabs/src/tab.dart';

class CloseListener extends InheritedWidget {
  CloseListener({
    Key? key,
    required this.child,
    required this.onClose,
  }) : super(key: key, child: child);

  @override
  final Widget child;

  final void Function(Tab) onClose;

  static CloseListener of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CloseListener>()!;
  }

  void close(Tab tab) {
    onClose(tab);
  }

  @override
  bool updateShouldNotify(CloseListener oldWidget) {
    return false;
  }
}
