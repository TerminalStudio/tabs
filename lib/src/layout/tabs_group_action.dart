import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:tabs/src/layout/tabs_group.dart';

class TabsGroupAction extends StatelessWidget {
  TabsGroupAction({this.icon, this.onTap});

  final IconData icon;
  final void Function(TabGroupController) onTap;

  @override
  Widget build(BuildContext context) {
    final group = TabGroupProvider.of(context).controller;
    return GestureDetector(
      onTap: () => onTap(group),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: EdgeInsets.only(bottom: 2),
          child: Icon(
            icon,
            size: 30,
            color: Color(0xFF9F9F9F),
          ),
        ),
      ),
    );
  }
}

class TabsGroupActions extends InheritedWidget {
  TabsGroupActions({
    Key key,
    @required this.child,
    this.actions = const [],
  }) : super(key: key, child: child);

  @override
  final Widget child;

  final List<TabsGroupAction> actions;

  static TabsGroupActions of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<TabsGroupActions>());
  }

  @override
  bool updateShouldNotify(TabsGroupActions oldWidget) {
    return false;
  }
}
