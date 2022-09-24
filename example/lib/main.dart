import 'package:example/tabs/counter_tab.dart';
import 'package:example/tabs/loading_tab.dart';
import 'package:example/tabs/start_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flex_tabs/flex_tabs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final document = TabsDocument();

  final tabsTheme = const TabsViewThemeData();

  final destinations = const [
    NavigationRailDestination(
      icon: Icon(Icons.home),
      selectedIcon: Icon(Icons.home),
      label: Text('Home'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.search),
      selectedIcon: Icon(Icons.search),
      label: Text('Search'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.settings),
      selectedIcon: Icon(Icons.settings),
      label: Text('Settings'),
    ),
  ];

  @override
  void initState() {
    super.initState();

    final root = Tabs(
      children: [
        StartTab(),
        TabItem(
          title: const Text('vi .zshrc'),
          content: const Center(child: Text('vi .zshrc')),
        ),
        LoadingTab(),
        CounterTab(),
      ],
    );

    // final root = Tabs();

    document.setRoot(root);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitlebar(context),
        Expanded(
          child: TabsView(
            document,
            theme: tabsTheme,
            actionBuilder: actionsBuilder,
          ),
        ),
      ],
    );
  }

  Widget _buildTitlebar(BuildContext context) {
    return Container(
      height: 28,
      color: tabsTheme.selectedBackgroundColor,
    );
  }

  List<TabsViewAction> actionsBuilder(Tabs tabs) {
    return [
      TabsViewAction(
        icon: CupertinoIcons.add,
        onPressed: () {
          final tab = StartTab();
          tabs.add(tab);
          tab.activate();
        },
      ),
    ];
  }
}
