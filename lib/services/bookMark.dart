import 'package:shared_preferences/shared_preferences.dart';

class BookMark {
  addBookmarked(id, bookMarked) async {
    bookMarked.contains(id) ? bookMarked.remove(id) : bookMarked.add(id);
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('bookmark', bookMarked);
  }

  setBookmarks(bookMarked) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('bookmark', bookMarked);
  }

  getBookmarked() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('bookmark');
  }
}
