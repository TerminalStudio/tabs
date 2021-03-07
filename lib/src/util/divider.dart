import 'package:flutter/material.dart';

class VerticalDivider extends StatelessWidget {
  const VerticalDivider({
    Key? key,
    this.width,
    required this.color,
    this.border,
  })  : assert(width == null || width >= 0.0),
        super(key: key);

  final double? width;
  final Color color;
  final BorderSide? border;

  @override
  Widget build(BuildContext context) {
    final width = this.width ?? 1.0;

    return SizedBox(
      width: width,
      child: Center(
        child: Container(
          width: width,
          decoration: BoxDecoration(
            color: color,
            border: Border.symmetric(
              vertical: border ?? BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({
    Key? key,
    this.height,
    required this.color,
    this.border,
  })  : assert(height == null || height >= 0.0),
        super(key: key);

  final double? height;
  final Color color;
  final BorderSide? border;

  @override
  Widget build(BuildContext context) {
    final height = this.height ?? 1.0;

    return SizedBox(
      height: height,
      child: Center(
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: color,
            border: Border.symmetric(
              horizontal: border ?? BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
