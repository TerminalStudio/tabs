import 'dart:async';

import 'package:example/tabs/files_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Tab;
import 'package:tabs/tabs.dart';

class LoadingTab extends Tab {
  LoadingTab() {
    title.value = const Text('Loading...');
    content.value = LoadingTabWidget(this);

    Timer(const Duration(seconds: 2), () {
      replace(FilesTab());
    });
  }
}

class LoadingTabWidget extends StatefulWidget {
  const LoadingTabWidget(this.tab, {Key? key}) : super(key: key);

  final LoadingTab tab;

  @override
  State<LoadingTabWidget> createState() => _LoadingTabWidgetState();
}

class _LoadingTabWidgetState extends State<LoadingTabWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder<double>(
        duration: const Duration(seconds: 2),
        tween: Tween(begin: 0, end: 1),
        builder: (BuildContext context, double value, Widget? child) {
          return CircularProgressIndicator(
            value: value,
          );
        },
      ),
    );
  }
}
