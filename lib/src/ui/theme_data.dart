import 'package:flutter/cupertino.dart';

class TabsViewThemeData {
  final Color labelColor;

  final Color backgroundColor;

  final Color hoverBackgroundColor;

  final Color selectedBackgroundColor;

  final Color separatorColor;

  final Color closeButtonColor;

  const TabsViewThemeData({
    this.labelColor = const Color.fromARGB(255, 90, 90, 90),
    this.backgroundColor = const Color.fromARGB(255, 222, 223, 222),
    this.hoverBackgroundColor = const Color.fromARGB(255, 209, 210, 209),
    this.selectedBackgroundColor = const Color.fromARGB(255, 235, 236, 235),
    this.separatorColor = const Color.fromARGB(255, 204, 205, 204),
    this.closeButtonColor = const Color.fromARGB(255, 110, 110, 110),
  });
}
