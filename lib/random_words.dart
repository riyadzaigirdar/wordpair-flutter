import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords>{
  final _entries = <WordPair>[];
  final _savedWordPair = Set<WordPair>();

  Widget _buildList(){
    _entries.addAll(generateWordPairs().take(10));
    return ListView.builder(
              padding: const EdgeInsets.all(10),
              // itemCount: _entries.length,
              itemBuilder: (context, item){
                if(item.isOdd) return Divider();

                final index = item ~/ 2;

                if(index >= _entries.length){
                  _entries.addAll(generateWordPairs().take(10));
                }
                return _buildRow(_entries[index]);
              }           
            );
  }
  
  Widget _buildRow(WordPair pair){
    // final alreadySaved = _savedWordPair.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase, style: TextStyle(fontSize: 20, color: Colors.black87),),
      trailing: _savedWordPair.contains(pair) ? Icon( Icons.favorite, color: Colors.pink,): Icon(Icons.favorite_border),
      onTap: (){
        setState(() {
          if(_savedWordPair.contains(pair)){
            _savedWordPair.remove(pair);
          }else{
            _savedWordPair.add(pair);
          }
        });
      },
    );
  }

  void _pushsaved(){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context){
        final Iterable<ListTile> tiles = _savedWordPair.map((WordPair pair){
           return ListTile(
             title:Text(pair.asPascalCase, style: TextStyle(fontSize: 16.0),)
           );
        });

        final List<Widget> divided = ListTile.divideTiles(context:context,tiles: tiles).toList();

        return Scaffold(
          appBar: AppBar(
            title: Container(child:Text("Saved Item",),alignment: Alignment.bottomCenter,),
          ),
          body: ListView(children: divided));
      }
    ));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Wordpair Riyad "),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushsaved),
          // IconButton(icon: Icon(Icons.festival), onPressed: _pushsaved)
        ],
        ),
      body: _buildList(),
    );
  }
}