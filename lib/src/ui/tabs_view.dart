import 'package:flutter/cupertino.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:tabs/src/model/document.dart';
import 'package:tabs/src/model/tabs.dart';
import 'package:tabs/src/ui/scope.dart';
import 'package:tabs/src/ui/tabs_area.dart';

class TabsView extends StatefulWidget {
  const TabsView(
    this.document, {
    Key? key,
    this.actionBuilder,
  }) : super(key: key);

  final TabsDocument document;

  final TabsViewActionBuilder? actionBuilder;

  static TabsView? of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<TabsView>();
  }

  @override
  State<TabsView> createState() => TabsViewState();
}

class TabsViewState extends State<TabsView> {
  @override
  void initState() {
    super.initState();
    widget.document.addListener(_onControllerChanged);
  }

  @override
  void didUpdateWidget(TabsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.document != oldWidget.document) {
      oldWidget.document.removeListener(_onControllerChanged);
      widget.document.addListener(_onControllerChanged);
    }
  }

  @override
  void dispose() {
    widget.document.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final root = widget.document.root;

    if (root == null) {
      return Container();
    }

    Widget child = MultiSplitViewTheme(
      data: MultiSplitViewThemeData(
        dividerThickness: 4,
        dividerPainter: DividerPainter(
          backgroundColor: CupertinoColors.systemGrey4,
        ),
      ),
      child: TabsArea(child: root),
    );

    return TabsDocumentScope(widget.document, child: child);
  }
}

class TabsViewAction {
  final IconData icon;

  final void Function()? onPressed;

  TabsViewAction({required this.icon, this.onPressed});
}

typedef TabsViewActionBuilder = List<TabsViewAction> Function(Tabs);
