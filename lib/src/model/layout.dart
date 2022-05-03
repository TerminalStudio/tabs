import 'package:flutter/widgets.dart';
import 'package:tabs/src/model/container.dart';

abstract class TabsLayout extends TabsContainer<TabsContainer> {
  TabsLayout([List<TabsContainer>? children]) : super(children);

  Axis get direction;

  @override
  bool remove(TabsContainer node) {
    if (!super.remove(node)) {
      return false;
    }

    if (children.length == 1) {
      final parent = this.parent;
      if (parent is TabsContainer) {
        parent.replace(this, children.first);
      }
    }

    return true;
  }
}

class TabsRow extends TabsLayout {
  TabsRow({List<TabsContainer>? children}) : super(children);

  @override
  final direction = Axis.horizontal;
}

class TabsColumn extends TabsLayout {
  TabsColumn({List<TabsContainer>? children}) : super(children);

  @override
  final direction = Axis.vertical;
}
