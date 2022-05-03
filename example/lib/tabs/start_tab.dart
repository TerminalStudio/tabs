import 'package:cupertino_lists/cupertino_lists.dart';
import 'package:example/tabs/dragged_tab.dart';
import 'package:example/tabs/loading_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flex_tabs/flex_tabs.dart';

class StartTab extends TabItem {
  StartTab() {
    title.value = const Text('Get Started');
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
  static final draggedTab = DraggedTab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 512),
        child: ListView(
          shrinkWrap: true,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                'Tabs Demo',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                'Library for building flexible tabbed Flutter applications.',
                style: TextStyle(
                    fontSize: 16, color: CupertinoColors.secondaryLabel),
              ),
            ),
            const SizedBox(height: 16),
            _ListTile(
              child: const Text('Open New Tab'),
              icon: const _SquireIcaon(
                color: CupertinoColors.systemBlue,
                icon: CupertinoIcons.add,
              ),
              onTap: () {
                final newTab = LoadingTab();
                widget.tab.parent?.add(newTab);
              },
            ),
            _ListTile(
              child: const Text('Open And Activate Tab'),
              icon: const _SquireIcaon(
                color: CupertinoColors.systemBlue,
                icon: CupertinoIcons.arrow_up_right,
              ),
              onTap: () {
                final newTab = LoadingTab();
                widget.tab.parent?.add(newTab);
                newTab.activate();
              },
            ),
            _ListTile(
              child: const Text('Replace Current Tab'),
              icon: const _SquireIcaon(
                color: CupertinoColors.systemBlue,
                icon: CupertinoIcons.refresh,
              ),
              onTap: () {
                final newTab = LoadingTab();
                widget.tab.replace(newTab);
                newTab.activate();
              },
            ),
            Draggable<TabItem>(
              data: draggedTab,
              feedback: Container(
                color: CupertinoColors.systemBlue.withAlpha(32),
                width: 64,
                height: 48,
              ),
              dragAnchorStrategy: pointerDragAnchorStrategy,
              child: _ListTile(
                child: const Text('Drag Me'),
                icon: const _SquireIcaon(
                  color: CupertinoColors.systemBlue,
                  icon: CupertinoIcons.hand_draw,
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile({
    Key? key,
    required this.child,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  final Widget child;

  final Widget icon;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile.notched(
      title: child,
      leading: icon,
      onTap: onTap,
    );
  }
}

class _SquireIcaon extends StatelessWidget {
  const _SquireIcaon({Key? key, required this.color, required this.icon})
      : super(key: key);

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.0,
      height: 30.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Center(
        child: Icon(
          icon,
          color: CupertinoColors.white,
          size: 18.0,
        ),
      ),
    );
  }
}
