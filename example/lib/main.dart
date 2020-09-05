import 'package:flutter/cupertino.dart';
import 'package:tabs/tabs.dart';

import 'package:flutter/material.dart' hide Tab, TabController;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var count = 0;
  final tabs = TabsController();
  final group = TabGroupController();

  @override
  void initState() {
    final group = TabsGroup(controller: this.group);

    tabs.replaceRoot(group);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TabsView(
          controller: tabs,
          actions: [
            TabsGroupAction(
              icon: CupertinoIcons.add,
              onTap: (group) {
                group.addTab(buildTab(), activate: true);
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        group.addTab(buildTab(), activate: true);
      }),
    );
  }

  Tab buildTab() {
    count++;

    final tab = TabController();

    tab.setContent(
      Center(
        child: Text('Window $count'),
      ),
    );

    return Tab(
      controller: tab,
      title: 'Window $count',
    );
  }
}
