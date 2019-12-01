import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RandomWordsGenerator extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _biggerFont =
      const TextStyle(fontSize: 18, fontFamily: "Arial");
  final Set<WordPair> _saved = Set<WordPair>();

  Widget _buildSuggestions() {
    print(_saved);
    if (_suggestions.length < 5) {
      _suggestions.addAll(generateWordPairs().take(5));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        final index = i;

        /* if (index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(5));
        } */
        if (index < _suggestions.length) {
          return _buildRow(_suggestions[index], index: index);
        }
      },
    );
  }

  Widget _buildRow(WordPair pair, {int index}) {
    final bool _already_saved = _saved.contains(pair);

    return Card(
        child: ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      subtitle: Text("This is list item " + (index + 1).toString()),
      isThreeLine: true,
      leading: Image(
        image: NetworkImage("https://i.imgur.com/LfV8TBp.jpg"),
        fit: BoxFit.contain,
      ),
      trailing: Icon(
        _already_saved ? Icons.favorite : Icons.favorite_border,
        color: _already_saved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          print("$index was tapped");
          if (_already_saved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    ));
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      final Iterable<Card> tiles = _saved.map((WordPair pair) {
        return Card(
          child : ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        ),);
      });
      final List<Widget> divided = tiles.toList();
      return Scaffold(
        appBar: AppBar(
          title : Text("Saved Suggestions"),
        ),
        body : ListView(children: divided),

      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List Generator"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.list),
              onPressed: _pushSaved,
            )
          ],
        ),
        body: _buildSuggestions());
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsGenerator createState() => new RandomWordsGenerator();
}
