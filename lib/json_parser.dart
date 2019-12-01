import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class RedditScraper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new RedditScraperHome(),
    );
  }
}

class RedditScraperHome extends StatefulWidget {
  RedditScraperHome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RedditScraperHomeState createState() => new _RedditScraperHomeState();
}

class _RedditScraperHomeState extends State<RedditScraperHome> {
  Future<List<Posts>> _getUsers() async {
    var data = await http.get("http://magnum.wtf/reddit");

    var jsonData = json.decode(data.body);

    List<Posts> post_list = [];

    for (var u in jsonData) {
      Posts posts = Posts(u["title"], u["author"], u["url"], u["thumbnail"]);

      post_list.add(posts);
    }

    print(post_list.length);

    return post_list;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Reddit Browser"),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              return Container(child: Center(child: Text("Loading...")));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(child: ListTile(
                    leading: Image(
                      image: NetworkImage(snapshot.data[index].thumbnail),
                      fit: BoxFit.contain,
                    ),
                    title: Text(snapshot.data[index].title),
                    subtitle: Text(snapshot.data[index].author),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(snapshot.data[index])));
                    },
                  ));
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Posts posts;

  DetailPage(this.posts);
  @override
  Widget build(BuildContext context) {
    var author = "u/" + posts.author;
    return Scaffold(
        appBar: AppBar(
          title: Text(posts.title),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Image(
                  image: NetworkImage(posts.thumbnail),
                  fit: BoxFit.contain,
                ),
                Text(
                  "Posted by $author",
                  style: TextStyle(fontSize: 18),
                ),
                RaisedButton(
                  child: Text("Click here to go to the Reddit post"),
                  onPressed: () => _launchURL(posts.url),
                ),
              ],
            ),
          ),
        ));
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class Posts {
  final String title;
  final String author;
  final String url;
  final String thumbnail;

  Posts(this.title, this.author, this.url, this.thumbnail);
}
