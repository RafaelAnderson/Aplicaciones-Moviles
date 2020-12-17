import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main()
{
  runApp(MyApp());
}

// void main() => runApp(MyApp()) ----> Otra forma :D
// stful ---> Para crear + enter

class MyApp extends StatelessWidget
{
  @override
  Widget build (BuildContext context)
  {
    //throw UnimplementedError();
    //final wordPair = WordPair.random();

    return MaterialApp(
      title: "Bienvenido a Flutter",
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget
{
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords>
{
  final List<WordPair> suggestions = <WordPair>[];
  final TextStyle biggerFont = TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context)
  {
    //final WordPair wordPair = WordPair.random();
    //return Text(wordPair.asPascalCase); //Mayúscula en cada inicio de palabra
    return Scaffold(
      appBar: AppBar(
        title: Text('App Name Generator!!!'),
      ),
      body: buildSuggestion(),
    );
  }

  Widget buildSuggestion()
  {
    return ListView.builder(
        padding: EdgeInsets.all(16),
        itemBuilder: (BuildContext context, int i){
          if(i.isOdd){
            return Divider();
          }
          final int index = i ~/ 2;

          if(index >= suggestions.length){
            suggestions.addAll(generateWordPairs().take(10));
          }
          return buildRow(suggestions[index]);
        },
    );
  }

  Widget buildRow(WordPair pair)
  {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: biggerFont,
      ),
    );
  }
}
