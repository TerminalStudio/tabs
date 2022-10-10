import 'package:flex_tabs/flex_tabs.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TabsDocument', () {
    test('can set root', () {
      final document = TabsDocument();
      final root = TabsColumn();

      document.setRoot(root);

      expect(document.root, root);
      expect(root.parent, document);
    });

    test('can get active tab', () {
      final document = TabsDocument();
      final root = TabsColumn();

      final layout1 = TabsRow();
      final layout2 = TabsRow();

      final group1 = Tabs();
      final group2 = Tabs();

      final tab1 = TabItem();
      final tab2 = TabItem();

      document.setRoot(root);

      root.add(layout1);
      layout1.add(layout2);

      layout1.add(group1);
      layout2.add(group2);

      group1.add(tab1);
      group2.add(tab2);

      expect(document.activeTab.value, tab2);

      tab1.activate();

      expect(document.activeTab.value, tab1);
    });
  });
}
