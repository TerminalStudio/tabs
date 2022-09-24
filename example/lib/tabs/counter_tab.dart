import 'package:flex_tabs/flex_tabs.dart';
import 'package:flutter/material.dart';

class CounterTab extends TabItem {
  CounterTab() {
    title.value = const Text('Counter Tab');
    content.value = CounterTabWidget(this);
  }

  /// Put state on the tab item to avoid atate loss on drag and drop.
  final counter = ValueNotifier<int>(0);
}

class CounterTabWidget extends StatelessWidget {
  const CounterTabWidget(this.tab, {super.key});

  final CounterTab tab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            ValueListenableBuilder(
              valueListenable: tab.counter,
              builder: (context, value, child) {
                return Text(
                  '$value',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          tab.counter.value++;
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
