import 'package:flutter/material.dart';
import 'package:insta_clone/services/getcomments.dart';

class Commentz extends StatefulWidget {
  const Commentz({Key? key}) : super(key: key);

  @override
  _CommentzState createState() => _CommentzState();
}

@override
class _CommentzState extends State<Commentz> {
  var comments;
  void initState() {
    super.initState();
    getComments();
  }

  getComments() async {
    comments = await Comments().getComments();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(child: Text("comment")),
            ],
          );
        });
  }
}
