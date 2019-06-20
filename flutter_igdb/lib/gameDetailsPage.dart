import 'package:flutter/material.dart';
import 'package:flutter_igdb/services/services.dart';
import 'package:flutter_igdb/models/gameDetails.dart';
import 'package:date_format/date_format.dart';
import 'dart:async';

class GameDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: RaisedButton(
            child: Text('Back To HomeScreen'),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: () => Navigator.pop(context)),
      ),
    );
  }
}
