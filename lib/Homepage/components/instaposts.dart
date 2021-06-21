import 'package:flutter/material.dart';
import 'package:insta_clone/Homepage/components/post.dart';

import 'package:insta_clone/services/getposts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Instaposts extends StatefulWidget {
  final posts;
  const Instaposts({Key? key, @required this.posts}) : super(key: key);
  @override
  @override
  _InstapostState createState() => _InstapostState();
}

class _InstapostState extends State<Instaposts> {
  List<String> bookMarked = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    this.fetchpost();
  }

  fetchpost() async {
    setState(() {
      isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    bookMarked = prefs.getStringList('bookmark') ?? [];
    setState(() {
      isLoading = false;
    });
  }

  addBookmarked(id) async {
    bookMarked.contains(id) ? bookMarked.remove(id) : bookMarked.add(id);
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('bookmark', bookMarked);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(child: Center(child: CircularProgressIndicator())),
        ],
      );
    }
    return ListView.builder(
        itemCount: widget.posts.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                  child: Post(
                      postObj: widget.posts[index], bookMarked: bookMarked)),
            ],
          );
        });
  }
}
