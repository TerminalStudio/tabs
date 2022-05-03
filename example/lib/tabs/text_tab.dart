import 'package:flutter/cupertino.dart';
import 'package:tabs/tabs.dart';

class StartTab extends Tab {
  StartTab() {
    title.value = const Text('Start');
    content.value = StartTabWidget(this);
  }
}

class StartTabWidget extends StatefulWidget {
  const StartTabWidget(this.tab, {Key? key}) : super(key: key);

  final StartTab tab;

  @override
  State<StartTabWidget> createState() => StartTabWidgetState();
}

class StartTabWidgetState extends State<StartTabWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 512),
        child: Text(
            'This is a demo of the tabs package. It is a simple example of how to use the tabs package.'),
      ),
    );
  }
}
