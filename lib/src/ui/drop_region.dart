import 'package:flutter/material.dart';
import 'package:flex_tabs/src/model/tab_item.dart';

typedef TabDropHandler = void Function(TabItem tab);

typedef TabWillDropHandler = bool Function(TabItem? tab);

class TabDropRegion extends StatelessWidget {
  const TabDropRegion({
    Key? key,
    required this.child,
    this.topMargin = 32,
    this.onDropLeft,
    this.onDropRight,
    this.onDropTop,
    this.onDropBottom,
    this.onWillDrop,
  }) : super(key: key);

  final Widget child;

  final double topMargin;

  final TabDropHandler? onDropLeft;

  final TabDropHandler? onDropRight;

  final TabDropHandler? onDropTop;

  final TabDropHandler? onDropBottom;

  final TabWillDropHandler? onWillDrop;

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
              child: TabDropArea(
                top: topMargin,
                onDrop: onDropTop,
                onWillDrop: onWillDrop,
              ),
            ),
            Positioned(
              bottom: 0,
              width: constrains.maxWidth,
              height: constrains.maxHeight * 0.5,
              child: TabDropArea(
                onDrop: onDropBottom,
                onWillDrop: onWillDrop,
              ),
            ),
            Positioned(
              right: 0,
              width: constrains.maxWidth * 0.5,
              height: constrains.maxHeight,
              child: TabDropArea(
                top: topMargin,
                left: constrains.maxWidth * 0.2,
                onDrop: onDropRight,
                onWillDrop: onWillDrop,
              ),
            ),
            Positioned(
              left: 0,
              width: constrains.maxWidth * 0.5,
              height: constrains.maxHeight,
              child: TabDropArea(
                top: topMargin,
                right: constrains.maxWidth * 0.2,
                onDrop: onDropLeft,
                onWillDrop: onWillDrop,
              ),
            ),
          ],
        );
      },
    );
  }
}

class TabDropArea extends StatefulWidget {
  const TabDropArea({
    Key? key,
    this.onDrop,
    this.onWillDrop,
    this.left = 0,
    this.right = 0,
    this.top = 0,
    this.bottom = 0,
  }) : super(key: key);

  final TabDropHandler? onDrop;

  final TabWillDropHandler? onWillDrop;

  final double left;

  final double right;

  final double top;

  final double bottom;

  @override
  _TabDropAreaState createState() => _TabDropAreaState();
}

class _TabDropAreaState extends State<TabDropArea> {
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
          left: widget.left,
          right: widget.right,
          top: widget.top,
          bottom: widget.bottom,
          child: DragTarget<TabItem>(
            builder: (context, accepted, rejected) => Container(),
            onAccept: (val) {
              setState(() => isAccepting = false);
              widget.onDrop?.call(val);
            },
            onWillAccept: (val) {
              final onWillDrop = widget.onWillDrop;

              if (onWillDrop != null && !onWillDrop(val)) {
                return false;
              }

              setState(() => isAccepting = true);
              return true;
            },
            onLeave: (_) {
              setState(() => isAccepting = false);
            },
          ),
        )
      ],
    );
  }
}
