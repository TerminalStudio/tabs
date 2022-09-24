import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flex_tabs/src/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flex_tabs/src/ui/drop_region.dart';
import 'package:flex_tabs/src/ui/utils.dart';
import 'package:flex_tabs/flex_tabs.dart';

class TabGroup extends StatefulWidget {
  final Tabs tabs;

  const TabGroup(this.tabs, {Key? key}) : super(key: key);

  @override
  State<TabGroup> createState() => _TabGroupState();
}

class _TabGroupState extends State<TabGroup> {
  static const kTabGroupHeight = 28.0;

  static const kMinTabWidth = 150.0;

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.tabs.addListener(_onChanged);
  }

  @override
  void didUpdateWidget(TabGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.tabs.removeListener(_onChanged);
    widget.tabs.addListener(_onChanged);
  }

  @override
  void dispose() {
    widget.tabs.removeListener(_onChanged);
    super.dispose();
  }

  void _onChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Column(
      children: [
        _buildTabBar(),
        const Divider(height: 1),
        Expanded(
          child: _buildTabContent(),
        ),
      ],
    );

    child = TabDropRegion(
      child: child,
      topMargin: kTabGroupHeight,
      onDropTop: _onDropTop,
      onDropBottom: _onDropBottom,
      onDropLeft: _onDropLeft,
      onDropRight: _onDropRight,
      onWillDrop: (tab) {
        return tab?.parent != widget.tabs || widget.tabs.length > 1;
      },
    );

    child = TabsScope(widget.tabs, child: child);

    return child;
  }

  void _onDropTop(TabItem incomingTab) {
    final parent = widget.tabs.parent;

    if (parent == null) return;

    final newTabGroup = Tabs();

    if (parent is TabsLayout && parent.direction == Axis.vertical) {
      parent.insert(
        parent.indexOf(widget.tabs),
        newTabGroup,
      );
    } else {
      parent.replace(
        widget.tabs,
        TabsColumn(children: [newTabGroup, widget.tabs]),
      );
    }

    incomingTab.detach();
    newTabGroup.add(incomingTab);
  }

  void _onDropBottom(TabItem incomingTab) {
    final parent = widget.tabs.parent;

    if (parent == null) return;

    final newTabGroup = Tabs();

    if (parent is TabsLayout && parent.direction == Axis.vertical) {
      parent.insert(
        parent.indexOf(widget.tabs) + 1,
        newTabGroup,
      );
    } else {
      parent.replace(
        widget.tabs,
        TabsColumn(children: [widget.tabs, newTabGroup]),
      );
    }

    incomingTab.detach();
    newTabGroup.add(incomingTab);
  }

  void _onDropLeft(TabItem incomingTab) {
    final parent = widget.tabs.parent;
    if (parent == null) return;

    final newTabGroup = Tabs();

    if (parent is TabsLayout && parent.direction == Axis.horizontal) {
      parent.insert(
        parent.indexOf(widget.tabs),
        newTabGroup,
      );
    } else {
      parent.replace(
        widget.tabs,
        TabsRow(children: [newTabGroup, widget.tabs]),
      );
    }

    incomingTab.detach();
    newTabGroup.add(incomingTab);
  }

  void _onDropRight(TabItem incomingTab) {
    final parent = widget.tabs.parent;
    if (parent == null) return;

    final newTabGroup = Tabs();

    if (parent is TabsLayout && parent.direction == Axis.horizontal) {
      parent.insert(
        parent.indexOf(widget.tabs) + 1,
        newTabGroup,
      );
    } else {
      parent.replace(
        widget.tabs,
        TabsRow(children: [widget.tabs, newTabGroup]),
      );
    }

    incomingTab.detach();
    newTabGroup.add(incomingTab);
  }

  Container _buildTabBar() {
    return Container(
      height: kTabGroupHeight,
      color: TabsViewTheme.of(context).backgroundColor,
      child: Row(
        children: [
          Expanded(
            child: _buildTabTiles(),
          ),
          _buildTabActions(),
        ],
      ),
    );
  }

  Widget _buildTabActions() {
    final actionBuilder = TabsView.of(context)?.actionBuilder;

    if (actionBuilder == null) return Container();

    return Row(
      children: actionBuilder(widget.tabs)
          .map((action) =>
              _TabActionButton(icon: action.icon, onPressed: action.onPressed))
          .separatedBy(const _TabTileSeparator()),
    );
  }

  Widget _buildTabTiles() {
    final children = widget.tabs.children.map(_buildTabTile);

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > kMinTabWidth * widget.tabs.length) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            children: children
                .map((child) => Expanded(child: child))
                .separatedBy(const _TabTileSeparator(), endWithSeparator: true),
          );
        }

        return ScrollConfiguration(
          behavior: const CupertinoScrollBehavior().copyWith(scrollbars: false),
          child: FadingEdgeScrollView.fromScrollView(
            gradientFractionOnStart: 0.1,
            gradientFractionOnEnd: 0.1,
            child: ListView(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              children: children
                  .map((child) => SizedBox(width: kMinTabWidth, child: child))
                  .separatedBy(const _TabTileSeparator()),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabTile(TabItem tab) {
    final activeTab = widget.tabs.activeTab;

    final tabTile = _TabTile(
      tab: tab,
      active: tab == activeTab,
    );

    const tabTileWhenDragging = AnimatedSize(
      duration: Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );

    Widget child = LayoutBuilder(
      builder: (context, constraints) {
        return Draggable<TabItem>(
          data: tab,
          feedback: SizedBox(
            width: constraints.maxWidth,
            height: kTabGroupHeight,
            child: DraggingShadow(
              child: tabTile,
            ),
          ),
          childWhenDragging: tabTileWhenDragging,
          child: tabTile,
        );
      },
    );

    child = GestureDetector(
      onTap: () {
        widget.tabs.activate(tab);
      },
      child: child,
    );

    return DragTarget<TabItem>(
      builder: (context, data, _) {
        return child;
      },
      onAccept: (incomingTab) {
        if (incomingTab == tab) {
          return;
        }

        if (incomingTab.parent != tab.parent) {
          final parent = tab.parent;
          if (parent != null) {
            parent.move(incomingTab, parent.indexOf(tab));
            parent.activate(incomingTab);
          }
        }

        incomingTab.detach();
        final parent = tab.parent;
        if (parent != null) {
          parent.insert(parent.indexOf(tab), incomingTab);
          parent.activate(incomingTab);
        }
      },
    );
  }

  Widget _buildTabContent() {
    final activeTab = widget.tabs.activeTab;

    if (activeTab == null) {
      return Container();
    }

    Widget child = ValueListenableBuilder<Widget?>(
      valueListenable: activeTab.content,
      builder: (context, content, child) {
        return content ?? Container();
      },
    );

    return TabScope(activeTab, child: child);
  }
}

class _TabTile extends StatefulWidget {
  const _TabTile({
    Key? key,
    required this.tab,
    this.active = false,
  }) : super(key: key);

  final TabItem tab;

  final bool active;

  @override
  State<_TabTile> createState() => _TabTileState();
}

class _TabTileState extends State<_TabTile> {
  var _hover = false;

  @override
  Widget build(BuildContext context) {
    final theme = TabsViewTheme.of(context);

    Widget child = Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(width: 28),
        Expanded(child: _buildContent()),
        _buildCloseButton(),
      ],
    );

    child = AnimatedContainer(
      duration:
          widget.active ? Duration.zero : const Duration(milliseconds: 100),
      constraints: const BoxConstraints.tightFor(height: double.infinity),
      decoration: BoxDecoration(
        color: widget.active
            ? theme.selectedBackgroundColor
            : _hover
                ? theme.hoverBackgroundColor
                : theme.backgroundColor,
        border: widget.active
            ? null
            : Border(top: BorderSide(color: theme.tabSeparatorColor)),
      ),
      child: child,
    );

    child = MouseRegion(
      onEnter: (_) {
        setState(() {
          _hover = true;
        });
      },
      onExit: (_) {
        setState(() {
          _hover = false;
        });
      },
      child: child,
    );

    child = TabScope(widget.tab, child: child);

    return child;
  }

  Widget _buildCloseButton() {
    return AnimatedOpacity(
      opacity: _hover ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 100),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: _TabTileButton(
          color: TabsViewTheme.of(context).closeButtonColor,
          icon: const Icon(CupertinoIcons.xmark),
          onPressed: () => widget.tab.detach(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    final theme = TabsViewTheme.of(context);

    Widget child = ValueListenableBuilder<Widget?>(
      valueListenable: widget.tab.title,
      builder: (context, title, child) {
        return title ?? Container();
      },
    );

    child = Center(
      child: DefaultTextStyle(
        style: TextStyle(
          color: theme.labelColor,
          fontSize: 12,
          overflow: TextOverflow.ellipsis,
        ),
        child: child,
      ),
    );

    return child;
  }
}

class _TabTileButton extends StatelessWidget {
  const _TabTileButton({
    Key? key,
    required this.icon,
    this.color,
    this.onPressed,
  }) : super(key: key);

  final Widget icon;

  final Color? color;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Material(
        color: Colors.transparent,
        child: IconButton(
          icon: icon,
          iconSize: 15,
          padding: const EdgeInsets.all(0),
          color: color,
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class _TabActionButton extends StatelessWidget {
  const _TabActionButton({
    Key? key,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  final IconData icon;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CupertinoButton(
        child: Icon(
          icon,
          size: 18,
          color: CupertinoColors.systemGrey.resolveFrom(context),
        ),
        padding: const EdgeInsets.all(0),
        minSize: 0,
        onPressed: onPressed,
      ),
    );
  }
}

class _TabTileSeparator extends StatelessWidget {
  const _TabTileSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      color: TabsViewTheme.of(context).tabSeparatorColor,
      width: 1,
      thickness: 1,
      // indent: 0,
      // endIndent: 0,
    );
  }
}

class DraggingShadow extends StatelessWidget {
  const DraggingShadow({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey4,
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset.zero,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: child,
    );
  }
}
