import 'package:flutter/material.dart';
import 'package:insta_clone/Homepage/components/bookmarkedonly.dart';
import 'package:insta_clone/Homepage/components/instapost.dart';
import 'package:insta_clone/services/bookMark.dart';
import 'package:insta_clone/services/getposts.dart';

class InstaHomePage extends StatefulWidget {
  const InstaHomePage({Key? key}) : super(key: key);

  @override
  _InstaHomePageState createState() => _InstaHomePageState();
}

class _InstaHomePageState extends State<InstaHomePage> {
  @override
  void initState() {
    super.initState();
    fetching();
  }

  fetching() async {
    var posts = await Posts().getPosts();
    var bookmarked = await BookMark().getBookmarked();
    postToDisplay = posts.where((e) => bookmarked.contains(e['id'])).toList();
  }

  bool showOnlyBookmarked = false;
  var postToDisplay;
  toggleBookmarked() async {
    showOnlyBookmarked = !showOnlyBookmarked;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.camera_alt),
        title: SizedBox(
          height: 35,
          child: Image.asset("assets/images/instagram.png"),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(Icons.send),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.home),
            Icon(Icons.search),
            Icon(Icons.add_box_outlined),
            IconButton(
              icon: Icon(Icons.bookmark),
              onPressed: () => toggleBookmarked(),
              color: showOnlyBookmarked ? Colors.red : Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                child: Icon(Icons.person),
              ),
            )
          ],
        ),
      ),
      body: showOnlyBookmarked
          ? BookmarkedOnly(posts: postToDisplay)
          : Instaposts(),
    );
  }
}
