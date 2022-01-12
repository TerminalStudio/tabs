import 'package:flutter/widgets.dart';
import 'package:tabs/src/layout/replace_listener.dart';
import 'package:tabs/src/layout/tabs_layout.dart';
import 'package:tabs/src/util/drag_bar.dart';
import 'package:tabs/src/util/extension.dart';

class TabColumn extends StatefulWidget implements TabsLayout {
  TabColumn({
    required this.top,
    required this.bottom,
    this.minHeight = 100,
  });

  final TabsLayout top;
  final TabsLayout bottom;
  final double minHeight;

  @override
  _TabColumnState createState() => _TabColumnState();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TabColumn($top, $bottom)';
  }

  @override
  int get tabCount => top.tabCount + bottom.tabCount;
}

class _TabColumnState extends State<TabColumn> {
  final keyTop = GlobalKey();
  final keyBottom = GlobalKey();

  var flexTop = 1.0;
  var flexBottom = 1.0;

  var isDragging = false;

  void onReplaceTop(TabsLayout? replacement) {
    if (replacement == null) {
      ReplaceListener.of(context).requestReplace(widget.bottom);
    } else {
      ReplaceListener.of(context).requestReplace(TabColumn(
        top: replacement,
        bottom: widget.bottom,
      ));
    }
  }

  void onReplaceBottom(TabsLayout? replacement) {
    if (replacement == null) {
      ReplaceListener.of(context).requestReplace(widget.top);
    } else {
      ReplaceListener.of(context).requestReplace(TabColumn(
        top: widget.top,
        bottom: replacement,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          key: keyTop,
          flex: flexTop.round(),
          child: ReplaceListener(
            child: widget.top,
            onReplace: onReplaceTop,
          ),
        ),
        GestureDetector(
          onHorizontalDragStart: (_) {
            setState(() => isDragging = true);
          },
          onHorizontalDragEnd: (_) {
            setState(() => isDragging = false);
          },
          onHorizontalDragUpdate: (details) {

            final flexTop =
                details.globalPosition.dy - keyTop.globalPaintBounds!.top;
            final flexBottom =
                keyBottom.globalPaintBounds!.bottom - details.globalPosition.dy;

            if (flexTop < widget.minHeight || flexBottom < widget.minHeight) {
              return;
            }

            setState(() {
              this.flexTop = flexTop;
              this.flexBottom = flexBottom;
            });
          },
          child: HorizontalDragBar(isDragging),
        ),
        Expanded(
          key: keyBottom,
          flex: flexBottom.round(),
          child: ReplaceListener(
            child: widget.bottom,
            onReplace: onReplaceBottom,
          ),
        ),
      ],
    );
  }
}
