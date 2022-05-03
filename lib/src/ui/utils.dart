import 'package:flutter/widgets.dart';

extension WidgetsX on Iterable<Widget> {
  List<Widget> separatedBy(
    Widget separator, {
    bool startWithSeparator = false,
    bool endWithSeparator = false,
  }) {
    final result = <Widget>[];

    if (startWithSeparator) {
      result.add(separator);
    }

    for (final item in this) {
      result.add(item);
      result.add(separator);
    }

    if (!endWithSeparator && result.isNotEmpty) {
      result.removeLast();
    }

    return result;
  }
}

extension StringX on String {
  String indent(int count) {
    final builder = StringBuffer();
    for (var line in split('\n')) {
      builder.writeln('${' ' * count}$line');
    }
    return builder.toString();
  }
}
