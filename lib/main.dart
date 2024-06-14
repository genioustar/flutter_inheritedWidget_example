import 'package:flutter/material.dart';
import 'package:flutter_inherited_widget_example/example/ex1_counter_inherited_widget_example.dart';
import 'package:flutter_inherited_widget_example/example/ex2_darkmode_inherited_widget_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter InheritedWidget Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ScreenList(),
      );
}

final List<Map<String, dynamic>> _example = [
  {
    'title': 'CounterInheritedWidgetExample',
    'widget': const CounterInheritedWidgetExample(),
  },
  {
    'title': 'DarkmodeInheritedWidgetExample',
    'widget': const DarkmodeInheritedWidgetExample(),
  },
];

class ScreenList extends StatelessWidget {
  const ScreenList({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Text(
              'InheritedWidget examples',
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: ListView.builder(
          itemCount: _example.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(_example[index]['title']),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => _example[index]['widget']),
            ),
          ),
        ),
      );
}
