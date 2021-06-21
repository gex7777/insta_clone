import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Homepage/components/comments.dart';
import 'package:insta_clone/services/bookMark.dart';
import 'package:insta_clone/services/getcomments.dart';

class Post extends StatefulWidget {
  final postObj;
  final bookMarked;
  const Post({Key? key, @required this.postObj, @required this.bookMarked})
      : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
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

  @override
  Widget build(BuildContext context) {
    var item = widget.postObj;
    var bookMarked = widget.bookMarked;
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
                onPressed: () {
                  BookMark().addBookmarked(id, bookMarked);
                  setState(() {});
                },
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
                    Commentz(),
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
}
