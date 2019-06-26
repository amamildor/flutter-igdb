import 'package:flutter/material.dart';
import 'package:flutter_igdb/services/services.dart';
import 'package:flutter_igdb/models/gameSearch.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_igdb/gameDetailsPage.dart';
import 'dart:async';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class SearchList extends StatefulWidget {
  SearchList({Key key}) : super(key:key);

  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<SearchList> {
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  bool _isSearching = false;
  String _error;
  List<GameSearch> _results = List();

  Timer debounceTimer;

  _SearchState() {
    _searchQuery.addListener(() {
      if (debounceTimer != null) {
        debounceTimer.cancel();
      }
      debounceTimer = Timer(Duration(milliseconds: 500), () {
        if (this.mounted) {
          performSearch(_searchQuery.text);
        }
      });
    });
  }

  void performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _error = null;
        _results = List();
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _error = null;
      _results = List();
    });

    final games = await getGames(query);
    if (this._searchQuery.text == query && this.mounted) {
      setState(() {
        _isSearching = false;
        if (games != null) {
          _results = games;
        } else {
          _error = 'Error searching games';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color.fromRGBO(0, 0, 0, 0.0));
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    return Scaffold(
      key: key,
      appBar: AppBar(
        centerTitle: true,
        title: TextField(
          cursorColor: Colors.blueAccent,
          cursorWidth: 1.5,
          autofocus: true,
          controller: _searchQuery,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Padding(
                padding: EdgeInsetsDirectional.only(end: 16.0),
            child: Icon(
              Icons.search,
              color: Colors.white,
            )),
            hintText: "Search games ...",
            hintStyle: TextStyle(color: Colors.grey)
          ),
        ),
      ),
      body: buildBody(context)
    );
  }

  Widget buildBody(BuildContext context) {
    if (_isSearching) {
      return CenterTitle('Searching igdb...');
    } else if (_error != null) {
      return CenterTitle(_error);
    } else if (_searchQuery.text.isEmpty) {
      return CenterTitle('Begin search by typing on search bar');
    } else {
      return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        itemCount: _results.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildRow(_results[index]);
        },
      );
    }
  }

  Widget _buildRow(GameSearch game) {
    return ListTile(
      title: Text(
        game.name,
      ),
      subtitle: Text(
          game.firstReleaseDate == null ? 'unknown' : formatDate(new DateTime.fromMillisecondsSinceEpoch(game.firstReleaseDate * 1000), [dd, '/', mm, '/', yyyy])
      ),
      leading: game.cover == null ? Image.asset(
        'assets/place_holder.png',
        width: 55,
        height: 55,
        fit: BoxFit.cover,
      ) : Image.network('https:' + game.cover.url),
      onTap: () {
        getGameDetails(game.id).then((response) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameDetailsPage(gameDetails: response),
            ),
          );
        });
      },
    );
  }
}

class CenterTitle extends StatelessWidget {
  final String title;

  CenterTitle(this.title);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      alignment: Alignment.center,
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline,
        textAlign: TextAlign.center,
      ),
    );
  }
}