import 'package:flutter/cupertino.dart';

class TabsViewThemeData {
  final Color labelColor;

  final Color backgroundColor;

  final Color hoverBackgroundColor;

  final Color selectedBackgroundColor;

  final Color separatorColor;

  const TabsViewThemeData({
    this.labelColor = CupertinoColors.label,
    this.backgroundColor = const Color.fromARGB(255, 222, 223, 222),
    this.hoverBackgroundColor = const Color.fromARGB(255, 209, 210, 209),
    this.selectedBackgroundColor = const Color.fromARGB(255, 235, 236, 235),
    this.separatorColor = const Color.fromARGB(255, 204, 205, 204),
  });
}
