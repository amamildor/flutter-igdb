import 'package:flutter/material.dart';
import 'package:flutter_igdb/services/services.dart';
import 'package:flutter_igdb/models/game.dart';
import 'package:date_format/date_format.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter IGDB',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter IGDB Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Game>gamesList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Game>>(
        future: getGames("divinity"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              gamesList = snapshot.data;
              return _buildGamesList();
            }
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget _buildGamesList() {
    return ListView.builder(
      itemCount: gamesList.length,
        //padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
        
          return _buildRow(gamesList[i]);
        });
  }

  Widget _buildRow(Game game) {
    return ListTile(
      title: Text(
        game.name,
      ),
      subtitle: Text(
          game.firstReleaseDate == null ? 'unknown' : formatDate(new DateTime.fromMillisecondsSinceEpoch(game.firstReleaseDate * 1000), [dd, '/', mm, '/', yyyy])
      ),
      leading: Image.network('https:' + game.cover.url),
    );
  }
}
