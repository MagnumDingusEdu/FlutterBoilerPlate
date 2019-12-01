import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';


class RedditScraper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new RedditScraperHome(title: 'Users'),
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

  Future<List<User>> _getUsers() async {

    var data = await http.get("http://magnum.wtf/reddit");

    var jsonData = json.decode(data.body);

    List<User> users = [];

    for(var u in jsonData){

      User user = User(u["title"], u["author"], u["url"], u["thumbnail"]);

      users.add(user);

    }

    print(users.length);

    return users;

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
            builder: (BuildContext context, AsyncSnapshot snapshot){
              print(snapshot.data);
              if(snapshot.data == null){
                return Container(
                  child: Center(
                    child: Text("Loading...")
                  )
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Image(
                        image: NetworkImage(
                          snapshot.data[index].thumbnail
                        ),
                        fit: BoxFit.contain,
                      ),
                      title: Text(snapshot.data[index].title),
                      subtitle: Text(snapshot.data[index].author),
                      onTap: (){

                        Navigator.push(context, 
                          new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]))
                        );

                      },
                    );
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

  final User user;

  DetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(user.title),
        )
    );
  }
}


class User {
  final String title;
  final String author;
  final String url;
  final String thumbnail;

  User( this.title, this.author, this.url, this.thumbnail);

}














/* 
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RedditHomePage extends StatefulWidget {
  final String title;
  RedditHomePage({Key key, this.title}) : super(key: key);

  @override
  _RedditHomePageState createState() => new _RedditHomePageState();
}

class _RedditHomePageState extends State<RedditHomePage> {
  Future<List<Post>> _getPosts() async {
    var data = await http.get("http://magnum.wtf/reddit");
    var jsonData = json.decode(data.body);

    List<Post> posts = [];

    for (var p in jsonData) {
      Post post = Post(p["title"], p["author"], p["thumbnail"], p["url"]);
      posts.add(post);
      print(p["title"]);
    }
    
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Redit"),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getPosts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading..."),
                ),
              );
            } else
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      child: ListTile(
                    title: snapshot.data[index].title,
                    subtitle: snapshot.data[index].author,
                  ));
                },
              );
          },
        ),
      ),
    );
  }
}

class Post {
  final String title;
  final String author;
  final String thumbnail;
  final String url;

  Post(this.author, this.title, this.url, this.thumbnail);
}
 */