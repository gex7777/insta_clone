import 'package:flutter/material.dart';
import 'package:insta_clone/services/getcomments.dart';

class Commentz extends StatefulWidget {
  const Commentz({Key? key}) : super(key: key);

  @override
  _CommentzState createState() => _CommentzState();
}

@override
class _CommentzState extends State<Commentz> {
  bool isLoading = false;
  var comments;
  void initState() {
    super.initState();
    getComments();
  }

  getComments() async {
    setState(() {
      isLoading = true;
    });
    comments = await Comments().getComments();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return CircularProgressIndicator();
    }
    return ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return Text("comment");
        });
  }
}
