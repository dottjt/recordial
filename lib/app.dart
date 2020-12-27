import 'package:flutter/material.dart';

class App extends StatefulWidget {
  App({Key key, this.component}) : super(key: key);

  final Widget component;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recordial',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: widget.component,
    );
  }
}
