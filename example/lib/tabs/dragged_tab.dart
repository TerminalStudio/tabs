import 'package:flutter/cupertino.dart';
import 'package:tabs/tabs.dart';

class DraggedTab extends TabItem {
  DraggedTab() {
    title.value = const Text('Dragged Tab');
    content.value = DraggedTabWidget(this);
  }
}

class DraggedTabWidget extends StatefulWidget {
  const DraggedTabWidget(this.tab, {Key? key}) : super(key: key);

  final DraggedTab tab;

  @override
  State<DraggedTabWidget> createState() => _DraggedTabWidgetState();
}

class _DraggedTabWidgetState extends State<DraggedTabWidget> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: Text('This tab is created by dragging.'),
      ),
    );
  }
}
