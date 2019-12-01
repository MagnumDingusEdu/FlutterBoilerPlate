import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

var brightness = Brightness.dark;

class RedditScraper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        brightness: brightness,

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
  var url = "http://magnum.wtf/reddit?limit=20&sr=all";
  Future<List<Posts>> _getUsers() async {
    var data = await http.get(url);

    var jsonData = json.decode(data.body);

    List<Posts> post_list = [];

    for (var u in jsonData) {
      Posts posts = Posts(u["title"], u["author"], u["url"], u["thumbnail"],
          u["image"], u["selftext"]);

      post_list.add(posts);
    }

    return post_list;
  }

  void _onRefreshTapped(String subreddit , String time, int limit) {
    setState(() {
      print("Refereshed");
      String query = "?"+"sr="+subreddit+"&"+"limit="+limit.toString()+"&"+"time="+time;
      url = "http://magnum.wtf/reddit"+query;
      print(url);
    });
  }
  
  void _colorThemeChange(){
    setState(() {
      if(brightness == Brightness.dark){
        brightness = Brightness.light;
      }else
      brightness = Brightness.dark;
    });
  }

  final _formKey = GlobalKey<FormState>();
  _queryData _data = new _queryData();

  void submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print("Printing the entered Data");
      print("Subreddit: ${_data.subreddit}");
      print("Limit: ${_data.queryLimit}");
      print("TimeLimit: ${_data.timeLimit}");
      _onRefreshTapped(_data.subreddit, _data.timeLimit, _data.queryLimit);
    }
  }
  String _validateSubreddit(String value) {
    if (value.length > 24) {
      return 'The subreddit must be less than 24 characters';
    }

    return null;
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Reddit Browser"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.compare_arrows),
        onPressed: _colorThemeChange,
      ),
      drawer: new Drawer(
        child: Padding(
        padding: EdgeInsets.all(0.0),
        child: new Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
              currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage("https://i.imgur.com/LfV8TBp.jpg"),
                ),
                onTap: () => print("This is the current user"),
              ),
              accountName: new Text("u/ThaparDong"),
              accountEmail: new Text("Reddit scraper, powered by magnum.wtf"),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.fill,
                 image: new NetworkImage("https://i.imgur.com/h60KTcC.jpg"),
                ),
              ),
            ),
              new Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                keyboardType: TextInputType.url,
                decoration: new InputDecoration(
                  hintText: "Enter subreddit name without r/",
                  labelText: 'Subreddit',
                  labelStyle: TextStyle(fontSize: 15),
                ),
                validator: this._validateSubreddit,
                onSaved: (String value){
                  this._data.subreddit = value;
                },

              )),
              new Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                keyboardType: TextInputType.url,
                decoration: new InputDecoration(
                  hintText: "hour/day/week/month/year/all",
                  labelText: 'Time',
                  labelStyle: TextStyle(fontSize: 15),
                ),
                validator: this._validateSubreddit,
                onSaved: (String value){
                  this._data.timeLimit = value;
                },

              )
              ),              
              new Padding(
                padding: EdgeInsets.symmetric(horizontal:20.0),
                child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                decoration: new InputDecoration(
                  hintText: "Enter the number of top posts to scrape",
                  labelText: "Scraping Limit",
                  labelStyle: TextStyle(fontSize: 15)
                ),
                onSaved: (String value){
                  this._data.queryLimit = int.parse(value);
                },
              
              )
              ),
              new Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                width: 60.0,
                child: new RaisedButton(
                  child: new Text(
                    'Scrape',
                    style: new TextStyle(
                      color: Colors.white
                    ),
                  ),
                  onPressed: this.submit,
                  color: Colors.blue,
                ),
                margin: new EdgeInsets.only(
                  top: 20.0
                ),
              )
              ),

            ],
          ),
        ),
      ),
      ),

      body: Container(
        child: FutureBuilder(
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(child: Center(child: Text("Loading...")));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      child: ListTile(
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
                  image: NetworkImage(posts.image),
                  fit: BoxFit.fitHeight,
                ),
                Container(
                  height: 20,
                ),
                new Expanded(
                  flex: 1,
                    child: SingleChildScrollView(
                  child: Text(
                    posts.selftext,
                    style: TextStyle(fontSize: 15),
                  ),
                )),
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
  final String selftext;
  final String image;

  Posts(this.title, this.author, this.url, this.thumbnail, this.image,
      this.selftext);
}

class _queryData {
  String subreddit = 'all';
  int queryLimit = 10;
  String timeLimit = 'day';
}
