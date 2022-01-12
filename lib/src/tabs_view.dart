import 'package:flutter/widgets.dart';
import 'package:tabs/src/layout/replace_listener.dart';
import 'package:tabs/src/layout/tabs_layout.dart';
import 'package:tabs/tabs.dart';

class TabsController with ChangeNotifier {
  TabsLayout? _root;
  TabsLayout? get root => _root;

  int get tabCount => _root?.tabCount ?? 0;

  void replaceRoot(TabsLayout? layout) {
    _root = layout;

    notifyListeners();

    // print('root $_root');
  }
}

class TabsView extends StatefulWidget {
  TabsView({
    TabsController? controller,
    this.actions = const [],
  }) : controller = controller ?? TabsController();

  final TabsController controller;
  final List<TabsGroupAction> actions;

  @override
  _TabsViewState createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView> {
  void onChange() {
    setState(() {});
  }

  @override
  void initState() {
    widget.controller.addListener(onChange);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(onChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller.root == null) {
      return Container();
    }

    return TabsGroupActions(
      actions: widget.actions,
      child: ReplaceListener(
        child: widget.controller.root!,
        onReplace: (layout) {
          widget.controller.replaceRoot(layout);
        },
      ),
    );
  }
}
