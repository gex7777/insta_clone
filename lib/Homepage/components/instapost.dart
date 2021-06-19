import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/services/getcomments.dart';
import 'package:insta_clone/services/getposts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Instapost extends StatefulWidget {
  const Instapost({Key? key}) : super(key: key);
  @override
  @override
  _InstapostState createState() => _InstapostState();
}

class _InstapostState extends State<Instapost> {
  List posts = [];
  List comments = [];
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
    var items = await Posts().getPosts();
    var allcomments = await Comments().getComments();
    setState(() {
      posts = items;
      comments = allcomments;
      isLoading = false;
    });
  }

  bool more = false;
  clickedMore() {
    setState(() {
      more = !more;
    });
  }

  bool viewComments = false;
  clickedViewComments() {
    setState(() {
      viewComments = !viewComments;
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
    if (posts.contains(null) || posts.length < 0 || isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return post(posts[index]);
        });
  }

  Widget post(item) {
    var channelname = item['channelname'];
    var image = item["high thumbnail"];
    var lowImage = item["low thumbnail"];
    var title = item["title"];
    String id = item["id"];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill, image: NetworkImage("$lowImage")),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    channelname,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: null,
              )
            ],
          ),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: new Image.network(
            "$image",
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.favorite),
                  Icon(Icons.comment),
                  Icon(Icons.send),
                ],
              ),
              IconButton(
                icon: Icon(Icons.bookmark),
                color: bookMarked.contains(id) ? Colors.red : Colors.black,
                onPressed: () => addBookmarked(id),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Liked by xyz, abc and 62,707 others",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                channelname,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10.0,
              ),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    text: more ? title : title.substring(0, 19),
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text: more ? "..show less" : "..more",
                          style: TextStyle(color: Colors.grey),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => clickedMore()),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: viewComments
              ? Column(
                  children: [
                    RichText(
                      text: TextSpan(
                          text: "dismiss comments",
                          style: TextStyle(color: Colors.grey),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => clickedViewComments()),
                    ),
                  ],
                )
              : RichText(
                  text: TextSpan(
                      text: "View comments",
                      style: TextStyle(color: Colors.grey),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => clickedViewComments()),
                ),
        )
      ],
    );
  }

  Widget comment(item) {
    var comment = item['comments'];
    var username = item['username'];
    return SizedBox(
        height: 20,
        child: Row(
          children: [
            Text(username,
                style: TextStyle(
                  color: Colors.grey,
                )),
            Text(comment)
          ],
        ));
  }
}
