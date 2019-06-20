import 'package:flutter/material.dart';
import 'package:flutter_igdb/searchPage.dart';
import 'package:flutter_igdb/gameDetailsPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Igdb Search',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: SearchList(),
        routes: <String, WidgetBuilder> {
          '/gameDetails': (BuildContext context) => GameDetailsPage(),
        });
  }
}
