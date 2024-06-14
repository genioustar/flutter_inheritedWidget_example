import 'package:flutter/material.dart';

class CounterInheritedWidgetExample extends StatefulWidget {
  const CounterInheritedWidgetExample({super.key});

  @override
  State<CounterInheritedWidgetExample> createState() =>
      _CounterInheritedWidgetExampleState();
}

class _CounterInheritedWidgetExampleState
    extends State<CounterInheritedWidgetExample> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
      print('Incrementing counter $_counter');
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Counter InheritedWidget Example'),
        ),
        body: Center(
          child: CounterInheritedWidget(
            counter: _counter,
            incrementCounter: _incrementCounter,
            child: const Center(
              child: CounterWidget(),
            ),
          ),
        ),
      );
}

class CounterInheritedWidget extends InheritedWidget {
  final int counter;
  final Function() incrementCounter;

  const CounterInheritedWidget(
      {super.key,
      required super.child,
      required this.counter,
      required this.incrementCounter});

  @override
  bool updateShouldNotify(covariant CounterInheritedWidget oldWidget) {
    return oldWidget.counter != counter;
  }

  static CounterInheritedWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CounterInheritedWidget>()!;
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = CounterInheritedWidget.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Counter: ${inheritedWidget.counter}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        ElevatedButton(
          onPressed: inheritedWidget.incrementCounter,
          child: const Text('Increment Counter'),
        ),
      ],
    );
  }
}
