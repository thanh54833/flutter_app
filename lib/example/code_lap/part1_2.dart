import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

/// thanh làm bài code lap 1
/// https://codelabs.developers.google.com/codelabs/first-flutter-app-pt1#6

void main() => runApp(LearnApp());

class LearnApp extends StatelessWidget {
  build(BuildContext context) {
    //final wordPair = WordPair.random();
    return MaterialApp(
      title: "title",
      theme: ThemeData(
        // Add the 3 lines from here...
        primaryColor: Colors.white,
      ),
      home: Scaffold(
          // appBar: AppBar(
          //   title: Text("Text"),
          // ),
          body: Center(
        // child: const Text("child"),
        //child: Text(wordPair.asPascalCase)),
        child: RandomWord(),
      )),
    );
  }
}

class RandomWord extends StatefulWidget {
  createState() => _RandomWordState();
}

class _RandomWordState extends State<RandomWord> {
  final List<WordPair> _suggestions = <WordPair>[]; // NEW
  final _saved = Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18); //

  build(BuildContext context) {
    // final wordPair = WordPair.random();
    // return Text("RandomWords ___ " + wordPair.asPascalCase);
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              pushSave();
            },
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  pushSave() {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Saved Suggestions'),
          ),
          body: ListView.builder(
            itemCount: _saved.length,
            itemBuilder: (context, index) {
              return Container(
                height: 50,
                child: _buildRow(_saved.elementAt(index)),
              );
            },
          ),
        );
      },
    ));
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        // The itemBuilder callback is called once per suggested
        // word pairing, and places each suggestion into a ListTile
        // row. For even rows, the function adds a ListTile row for
        // the word pairing. For odd rows, the function adds a
        // Divider widget to visually separate the entries. Note that
        // the divider may be difficult to see on smaller devices.
        itemBuilder: (BuildContext _context, int i) {
          // Add a one-pixel-high divider widget before each row
          // in the ListView.
          if (i.isOdd) {
            return Divider();
          }

          // The syntax "i ~/ 2" divides i by 2 and returns an
          // integer result.
          // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
          // This calculates the actual number of word pairings
          // in the ListView,minus the divider widgets.
          final int index = i ~/ 2;
          // If you've reached the end of the available word
          // pairings...
          if (index >= _suggestions.length) {
            // ...then generate 10 more and add them to the
            // suggestions list.
            _suggestions.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved != true) {
            _saved.add(pair);
          } else {
            _saved.remove(pair);
          }
        });
      },
    );
  }
}
