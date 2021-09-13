import 'package:flutter/material.dart' hide Tab;
import 'package:tabs/src/layout/tabs_column.dart';
import 'package:tabs/src/layout/tabs_group.dart';
import 'package:tabs/src/layout/tabs_layout.dart';
import 'package:tabs/src/layout/tabs_row.dart';
import 'package:tabs/src/tab.dart';

import '../../tabs.dart';

class TabAcceptRegion extends StatelessWidget {
  TabAcceptRegion({
    required this.child,
    required this.original,
    required this.onReplace,
    required this.mainController,
  });

  final Widget child;
  final TabsLayout original;
  final void Function(TabsLayout) onReplace;
  final TabsController mainController;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return Stack(
          children: [
            Positioned.fill(child: child),
            Positioned(
              top: 0,
              width: constrains.maxWidth,
              height: constrains.maxHeight * 0.5,
              child: TabAcceptArea(
                top: 32,
                onAccept: (tab) {
                  final controller = TabGroupController(mainController);
                  controller.addTab(tab);
                  final group = TabsGroup(controller: controller);
                  onReplace(TabColumn(top: group, bottom: original));
                },
              ),
            ),
            Positioned(
              bottom: 0,
              width: constrains.maxWidth,
              height: constrains.maxHeight * 0.5,
              child: TabAcceptArea(
                onAccept: (tab) {
                  final controller = TabGroupController(mainController);
                  controller.addTab(tab);
                  final group = TabsGroup(controller: controller);
                  onReplace(TabColumn(top: original, bottom: group));
                },
              ),
            ),
            Positioned(
              right: 0,
              width: constrains.maxWidth * 0.5,
              height: constrains.maxHeight,
              child: TabAcceptArea(
                top: 32,
                left: constrains.maxWidth * 0.2,
                onAccept: (tab) {
                  final controller = TabGroupController(mainController);
                  controller.addTab(tab);
                  final group = TabsGroup(controller: controller);
                  onReplace(TabRow(left: original, right: group));
                },
              ),
            ),
            Positioned(
              left: 0,
              width: constrains.maxWidth * 0.5,
              height: constrains.maxHeight,
              child: TabAcceptArea(
                top: 32,
                right: constrains.maxWidth * 0.2,
                onAccept: (tab) {
                  final controller = TabGroupController(mainController);
                  controller.addTab(tab);
                  final group = TabsGroup(controller: controller);
                  onReplace(TabRow(left: group, right: original));
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class TabAcceptArea extends StatefulWidget {
  const TabAcceptArea({
    Key? key,
    required this.onAccept,
    this.left,
    this.right,
    this.top,
    this.bottom,
  }) : super(key: key);

  final void Function(Tab) onAccept;
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;

  @override
  _TabAcceptAreaState createState() => _TabAcceptAreaState();
}

class _TabAcceptAreaState extends State<TabAcceptArea> {
  bool isAccepting = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (isAccepting)
          IgnorePointer(
            child: Container(
              color: Colors.blue.withAlpha(127),
            ),
          ),
        Positioned.fill(
          left: widget.left ?? 0,
          right: widget.right ?? 0,
          top: widget.top ?? 0,
          bottom: widget.bottom ?? 0,
          child: DragTarget<Tab>(
            builder: (context, accepted, rejected) => Container(),
            onAccept: (val) {
              if (mounted) {
                setState(() => isAccepting = false);
              }
              widget.onAccept(val);
            },
            onWillAccept: (val) {
              if (mounted) {
                setState(() => isAccepting = true);
              }
              return true;
            },
            onLeave: (_) {
              if (mounted) {
                setState(() => isAccepting = false);
              }
            },
          ),
        )
      ],
    );
  }
}
