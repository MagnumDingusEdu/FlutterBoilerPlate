import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<Post>> _getPosts() async {
    var data = await http.get("http://magnum.wtf/reddit");
    var jsonData = json.decode(data.body);

    List<Post> posts = [];

    for (var p in jsonData) {
      Post post = Post(p["title"], p["author"], p["thumbnail"], p["url"]);
      print(p["title"]);
      posts.add(post);
    }
    print(posts);
    return posts;
  }

void main(List<String> args) {
  var temp = _getPosts();
}
class Post {
  final String title;
  final String author;
  final String thumbnail;
  final String url;

  Post(this.author, this.title, this.url, this.thumbnail);
}
