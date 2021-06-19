import 'package:http/http.dart' as http;
import 'dart:convert';

class Comments {
  getComments() async {
    var res = await http.get(Uri.parse("http://cookbookrecipes.in/test.php"));
    if (res.statusCode == 200) {
      Object obj = json.decode(res.body);
      return obj;
    }
  }
}
