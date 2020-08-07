import 'package:flutter/widgets.dart';

class VerticalDivider extends StatelessWidget {
  const VerticalDivider({
    Key key,
    this.width,
    this.color,
  })  : assert(width == null || width >= 0.0),
        super(key: key);

  final double width;

  final Color color;

  @override
  Widget build(BuildContext context) {
    final width = this.width ?? 1.0;

    return SizedBox(
      width: width,
      child: Center(
        child: Container(
          width: width,
          color: color,
        ),
      ),
    );
  }
}

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({
    Key key,
    this.height,
    this.color,
  })  : assert(height == null || height >= 0.0),
        super(key: key);

  final double height;

  final Color color;

  @override
  Widget build(BuildContext context) {
    final height = this.height ?? 1.0;

    return SizedBox(
      height: height,
      child: Center(
        child: Container(
          height: height,
          color: color,
        ),
      ),
    );
  }
}
