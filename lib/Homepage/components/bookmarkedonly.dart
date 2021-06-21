import 'package:flutter/material.dart';

import 'package:insta_clone/Homepage/components/post.dart';
import 'package:insta_clone/services/bookMark.dart';
import 'package:insta_clone/services/getposts.dart';

class BookmarkedOnly extends StatefulWidget {
  const BookmarkedOnly({Key? key}) : super(key: key);

  @override
  _BookmarkedOnlyState createState() => _BookmarkedOnlyState();
}

@override
class _BookmarkedOnlyState extends State<BookmarkedOnly> {
  List bookmarked = [];
  bool isLoading = false;
  List postToDisplay = [];
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    fetching();
    setState(() {
      isLoading = false;
    });
  }

  fetching() async {
    var posts = await Posts().getPosts();
    bookmarked = await BookMark().getBookmarked();
    postToDisplay = posts.where((e) => bookmarked.contains(e['id'])).toList();
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
        itemCount: postToDisplay.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                  child: Post(
                      postObj: postToDisplay[index], bookMarked: bookmarked)),
            ],
          );
        });
  }
}
