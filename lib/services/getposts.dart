import 'package:http/http.dart' as http;
import 'dart:convert';

class Posts {
  getPosts() async {
    var res = await http.get(Uri.parse(
        "https://hiit.ria.rocks/videos_api/cdn/com.rstream.crafts?versionCode=40&lurl=Canvas%20painting%20ideas"));
    if (res.statusCode == 200) {
      Object obj = json.decode(res.body);
      return obj;
    }
  }
}
