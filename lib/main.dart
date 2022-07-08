import 'package:flutter/material.dart';

import 'package:wingload_calc/calculator.dart';
import 'package:wingload_calc/home.dart';

void main() {
  runApp(const WingLoadCalculator());
}

class WingLoadCalculator extends StatelessWidget {
  const WingLoadCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wing Load Calculator',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const App(title: 'Super helpful and useful app'),
    );
  }
}

class App extends StatefulWidget {
  const App({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int currentIndex = 1;

  static const List<Widget> widgets = <Widget>[
    Home(),
    Calculator(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calculate), label: 'Wing Load Calculator'),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: widgets.elementAt(currentIndex),
    );
  }
}
