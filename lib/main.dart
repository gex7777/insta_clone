import 'package:flutter/material.dart';

import 'Homepage/homescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insta clone',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: InstaHomePage(),
    );
  }
}
