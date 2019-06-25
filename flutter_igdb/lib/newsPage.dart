import 'package:flutter/material.dart';
import 'package:flutter_igdb/models/pulses.dart';
import 'package:date_format/date_format.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => new _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Page'),
      ),
      body: ListView(
        children: <Widget>[

        ],
      ),
    );
  }
}