import 'package:flutter/widgets.dart';
import 'package:flutter_tabs/src/model/node.dart';
import 'package:flutter_tabs/src/ui/utils.dart';

abstract class TabsContainer<T extends TabsNode> with TabsNode, ChangeNotifier {
  TabsContainer([List<T>? children]) {
    if (children != null) {
      _children.addAll(children);
    }
    for (var child in _children) {
      child.parent = this;
    }
  }

  final _children = <T>[];

  List<T> get children => List.unmodifiable(_children);

  int get length {
    return _children.length;
  }

  void add(T node) {
    if (_children.contains(node)) {
      return;
    }

    _children.add(node);

    node.parent = this;

    notifyListeners();
  }

  void replace(T oldNode, T newNode) {
    if (!_children.contains(oldNode)) {
      return;
    }

    final index = _children.indexOf(oldNode);
    _children[index] = newNode;

    if (oldNode.parent == this) {
      oldNode.parent = null;
    }

    newNode.parent = this;

    notifyListeners();
  }

  void swap(T node1, T node2) {
    if (!_children.contains(node1) || !_children.contains(node2)) {
      return;
    }

    final index1 = _children.indexOf(node1);
    final index2 = _children.indexOf(node2);

    _children[index1] = node2;
    _children[index2] = node1;

    notifyListeners();
  }

  void move(T node, int index) {
    if (!_children.contains(node)) {
      return;
    }

    final oldIndex = _children.indexOf(node);

    if (oldIndex == index) {
      return;
    }

    _children.removeAt(oldIndex);
    _children.insert(index, node);

    notifyListeners();
  }

  bool remove(T node) {
    if (_children.remove(node)) {
      node.parent = null;
      notifyListeners();
      return true;
    }
    return false;
  }

  void removeAll() {
    for (var child in _children) {
      child.parent = null;
    }
    _children.clear();
    notifyListeners();
  }

  void insert(int index, T node) {
    if (_children.contains(node)) {
      return;
    }

    _children.insert(index, node);

    node.parent = this;

    notifyListeners();
  }

  int indexOf(T node) {
    return _children.indexOf(node);
  }

  @override
  String toString() => '$runtimeType\n${children.join('\n').indent(2)}';
}
