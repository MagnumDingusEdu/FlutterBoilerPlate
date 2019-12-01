import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QueryForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QueryFormState();
  }
}

class _QueryFormState extends State<QueryForm> {
  final _formKey = GlobalKey<FormState>();
  _queryData _data = new _queryData();

  void submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print("Printing the entered Data");
      print("Subreddit: ${_data.subreddit}");
      print("Limit: ${_data.queryLimit}");
      print("TimeLimit: ${_data.timeLimit}");
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => print("Button pressed"),
      ),
      body: new Container(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: new Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              new TextFormField(
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

              ),
              new TextFormField(
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

              ),              
              new TextFormField(
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
              
              ),
              new Container(
                width: 100.0,
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
            ],
          ),
        ),
      ),
    ),
    );
  }
}

class _queryData {
  String subreddit = 'all';
  int queryLimit = 10;
  String timeLimit = 'day';
}
