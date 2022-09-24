import 'package:flutter/cupertino.dart';

class TabsViewThemeData {
  final Color labelColor;

  final Color backgroundColor;

  final Color hoverBackgroundColor;

  final Color selectedBackgroundColor;

  final Color tabSeparatorColor;

  final Color groupDividerColor;

  final double groupDividerThickness;

  final Color closeButtonColor;

  const TabsViewThemeData({
    this.labelColor = const Color.fromARGB(255, 90, 90, 90),
    this.backgroundColor = const Color.fromARGB(255, 222, 223, 222),
    this.hoverBackgroundColor = const Color.fromARGB(255, 209, 210, 209),
    this.selectedBackgroundColor = const Color.fromARGB(255, 239, 240, 240),
    this.tabSeparatorColor = const Color.fromARGB(255, 204, 205, 204),
    this.groupDividerColor = const Color.fromARGB(255, 170, 170, 170),
    this.groupDividerThickness = 4,
    this.closeButtonColor = const Color.fromARGB(255, 110, 110, 110),
  });
}
