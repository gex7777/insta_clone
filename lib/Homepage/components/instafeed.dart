import 'package:flutter/material.dart';
import 'package:insta_clone/Homepage/components/instapost.dart';

class Instafeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [Flexible(child: Instapost())],
    );
  }
}
