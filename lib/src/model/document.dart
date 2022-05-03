import 'package:tabs/src/model/container.dart';

class TabsDocument extends TabsContainer<TabsContainer> {
  TabsContainer? get root => children.isNotEmpty ? children.first : null;

  void setRoot(TabsContainer? root) {
    removeAll();
    if (root != null) {
      add(root);
    }
  }
}
