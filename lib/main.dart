import 'package:flutter/material.dart';
import 'package:flutter_derp/page/home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final Widget home;

  MyApp({this.home}) {
    // todo
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter derp",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white
      ),
      home: HomePage()
    );
  }
}