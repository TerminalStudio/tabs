import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_tabs/flutter_tabs.dart';

class FilesTab extends TabItem {
  FilesTab() {
    title.value = const Text('Browse Files');
    content.value = FilesTabWidget(this);
  }
}

class FilesTabWidget extends StatefulWidget {
  const FilesTabWidget(this.tab, {Key? key}) : super(key: key);

  final FilesTab tab;

  @override
  State<FilesTabWidget> createState() => _FilesTabWidgetState();
}

class _FilesTabWidgetState extends State<FilesTabWidget> {
  late final TreeViewController controller;

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final rootNode = TreeNode(id: '/', label: 'root');

    rootNode.addChildren([
      TreeNode(id: 'home', label: 'home'),
      TreeNode(id: 'bin', label: 'bin'),
      TreeNode(id: 'etc', label: 'etc'),
      TreeNode(id: 'usr', label: 'usr'),
      TreeNode(id: 'var', label: 'var'),
    ]);

    rootNode.children.first.addChildren([
      TreeNode(id: 'Documents', label: 'Documents'),
      TreeNode(id: 'Downloads', label: 'Downloads'),
      TreeNode(id: 'Pictures', label: 'Pictures'),
      TreeNode(id: 'Videos', label: 'Videos'),
    ]);

    controller = TreeViewController(
      rootNode: rootNode,
    );

    controller.expandAll();

    // controller.refreshNode(node)
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TreeView(
        theme: const TreeViewTheme(
          indent: 20,
          lineStyle: LineStyle.scoped,
        ),
        nodeBuilder: (_, node) => _TreeNodeTile(node),
        controller: controller,
        scrollController: scrollController,
      ),
    );
  }
}

class _TreeNodeTile extends StatelessWidget {
  const _TreeNodeTile(this.node, {Key? key}) : super(key: key);

  final TreeNode node;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final treeNodeScope = TreeNodeScope.of(context);
        treeNodeScope.toggleExpanded(context);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const LinesWidget(),
          const NodeWidgetLeadingIcon(
            useFoldersOnly: true,
            splashRadius: 20,
          ),
          Text(node.id),
        ],
      ),
    );
  }
}
