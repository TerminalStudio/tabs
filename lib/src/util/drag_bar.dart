import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:tabs/src/util/divider.dart';

// const _kColor = Color(0xFF3A3D3F);
// const _kColor = Color(0xFF1D1D1D);
const _kColor = Color(0xFF2D2D2D);
const _kActiveColor = Color(0xFF3A3D3F);

class HorizontalDragBar extends StatelessWidget {
  HorizontalDragBar(this.isDragging);

  final bool isDragging;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.resizeRow,
      child: HorizontalDivider(
        height: 8,
        color: isDragging ? _kActiveColor : _kColor,
        border: BorderSide(
          color: Colors.grey[900]!,
          width: 1,
        ),
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
      cursor: SystemMouseCursors.resizeColumn,
      child: VerticalDivider(
        width: 8,
        color: isDragging ? _kActiveColor : _kColor,
        border: BorderSide(
          color: Colors.grey[900]!,
          width: 1,
        ),
      ),
    );
  }
}
