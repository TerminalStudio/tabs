import 'package:flex_tabs/flex_tabs.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tabs', () {
    test('adopt tabs in constructor', () {
      final tab1 = TabItem();
      final tab2 = TabItem();

      final tabs = Tabs(children: [tab1, tab2]);

      expect(tab1.parent, tabs);
      expect(tab2.parent, tabs);
      expect(tabs.children, [tab1, tab2]);
      expect(tabs.activeTab, tab1);
    });

    test('can add tabs', () {
      final tab1 = TabItem();
      final tab2 = TabItem();

      final tabs = Tabs();

      tabs.add(tab1);
      tabs.add(tab2);

      expect(tab1.parent, tabs);
      expect(tab2.parent, tabs);
      expect(tabs.children, [tab1, tab2]);
      expect(tabs.activeTab, tab1);
    });

    test('can remove tabs', () {
      final tab1 = TabItem();
      final tab2 = TabItem();

      final tabs = Tabs(children: [tab1, tab2]);

      tabs.remove(tab1);

      expect(tab1.parent, null);
      expect(tab2.parent, tabs);
      expect(tabs.children, [tab2]);
      expect(tabs.activeTab, tab2);
    });
  });
}
