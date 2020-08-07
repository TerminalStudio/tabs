import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:tabs/src/util/divider.dart';

class HorizontalDragBar extends StatelessWidget {
  HorizontalDragBar(this.isDragging);

  final bool isDragging;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: HorizontalDivider(
        height: 8,
        color: isDragging ? Colors.grey : Color(0xFF1D1D1D),
      ),
    );
  }
}

class VerticalDragBar extends StatelessWidget {
  VerticalDragBar(this.isDragging);

  final bool isDragging;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: VerticalDivider(
        width: 8,
        color: isDragging ? Colors.grey : Color(0xFF1D1D1D),
      ),
    );
  }
}
