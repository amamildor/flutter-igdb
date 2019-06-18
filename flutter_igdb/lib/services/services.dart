import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_igdb/models/game.dart';
import 'dart:io';

String url = 'https://api-v3.igdb.com';

//class GameSearchRequest: APIRequest {
//var method = RequestType.POST
//var path = "games"
//var parameters = [String: String]()
//var body: String


Future<List<Game>> getGames(String search) async {
  final response = await http.post('$url/games',
  headers: {
    "Accept": "application/json",
    "user-key": "66f9368c53abc2ef45b87aa438fa4076"
      },
  body: {"fields": "name, first_release_date, release_dates, cover.*,platforms.*, platforms.platform_logo.*, platforms.versions.*",
      "search": search});
  return gameFromJson(response.body);
}
