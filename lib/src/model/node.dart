import 'package:flex_tabs/src/model/container.dart';
import 'package:flex_tabs/src/model/document.dart';
import 'package:flex_tabs/src/model/tab_item.dart';

/// A node in the tabs tree. Can be a [TabsContainer] or a [TabItem].
abstract class TabsNode {
  /// The parent of this node.
  TabsContainer? parent;

  /// Returns the ancestors of this node. The first element is the parent of
  /// this node, the last element is the root of the tree (a [TabsDocument]).
  Iterable<TabsNode> get ancestors sync* {
    var node = parent;
    while (node != null) {
      yield node;
      node = node.parent;
    }
  }

  /// Returns the root of the tree that this node belongs to. null if this node
  /// is not in a [TabsDocument].
  TabsDocument? get document {
    for (var ancestor in ancestors) {
      if (ancestor is TabsDocument) {
        return ancestor;
      }
    }
    return null;
  }
}
