import 'package:flutter/widgets.dart';
import 'package:tabs/src/layout/replace_listener.dart';
import 'package:tabs/src/layout/tabs_layout.dart';
import 'package:tabs/src/util/drag_bar.dart';
import 'package:tabs/src/util/extension.dart';

class TabRow extends StatefulWidget implements TabsLayout {
  TabRow({
    required this.left,
    required this.right,
    this.minWidth = 100,
  });

  final TabsLayout left;
  final TabsLayout right;
  final double minWidth;

  @override
  _TabRowState createState() => _TabRowState();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TabRow($left, $right)';
  }

  @override
  int get tabCount => left.tabCount + right.tabCount;
}

class _TabRowState extends State<TabRow> {
  final keyLeft = GlobalKey();
  final keyRight = GlobalKey();

  var flexLeft = 1.0;
  var flexRight = 1.0;

  var isDragging = false;

  void onReplaceLeft(TabsLayout? replacement) {
    if (replacement == null) {
      ReplaceListener.of(context).requestReplace(widget.right);
    } else {
      ReplaceListener.of(context).requestReplace(TabRow(
        left: replacement,
        right: widget.right,
      ));
    }
  }

  void onReplaceRight(TabsLayout? replacement) {
    if (replacement == null) {
      ReplaceListener.of(context).requestReplace(widget.left);
    } else {
      ReplaceListener.of(context).requestReplace(TabRow(
        left: widget.left,
        right: replacement,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          Expanded(
            key: keyLeft,
            flex: flexLeft.round(),
            child: ReplaceListener(
              child: widget.left,
              onReplace: onReplaceLeft,
            ),
          ),
          GestureDetector(
            onVerticalDragStart: (_) {
              setState(() => isDragging = true);
            },
            onVerticalDragEnd: (_) {
              setState(() => isDragging = false);
            },
            onVerticalDragUpdate: (details) {
              final flexLeft =
                  details.globalPosition.dx - keyLeft.globalPaintBounds!.left;
              final flexRight =
                  keyRight.globalPaintBounds!.right - details.globalPosition.dx;

              if (flexLeft < widget.minWidth || flexRight < widget.minWidth) {
                return;
              }

              setState(() {
                this.flexLeft = flexLeft;
                this.flexRight = flexRight;
              });
            },
            child: VerticalDragBar(isDragging),
          ),
          Expanded(
            key: keyRight,
            flex: flexRight.round(),
            child: ReplaceListener(
              child: widget.right,
              onReplace: onReplaceRight,
            ),
          ),
        ],
      );
    });
  }
}
