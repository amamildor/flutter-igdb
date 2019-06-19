import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_igdb/models/game.dart';
import 'package:igdb_client/igdb_client.dart';

var client = new IGDBClient('amamildor', '66f9368c53abc2ef45b87aa438fa4076');

String url = 'https://api-v3.igdb.com';

Future<List<Game>> getGames(String search) async {

  var params = new IGDBRequestParameters(
      search: search,
      fields: ['name', 'first_release_date', 'release_dates', 'cover.*','platforms.*', 'platforms.platform_logo.*', 'platforms.versions.*']
  );

  final response = await makeRequest('$url/games', params.toBody());
  /*final response = await http.post('$url/games',
  headers: {
    "Accept": "application/json",
    "user-key": "66f9368c53abc2ef45b87aa438fa4076"
      },
  body: {"fields": "name, first_release_date, release_dates, cover.*,platforms.*, platforms.platform_logo.*, platforms.versions.*",
      "search": search});
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');*/
  return response;
}


Future<List<Game>> makeRequest(String url, String body) async {
  var uri = Uri.parse(url);
  var httpClient = new HttpClient();
  var request = await httpClient.postUrl(uri);
  request..headers.add('user-key', '66f9368c53abc2ef45b87aa438fa4076')
    ..headers.add('User-Agent', 'amamildor')
    ..headers.add('Accept', 'application/json')
    ..write(body);

  var resp = await request.close();
  var responseBody = await resp.transform(utf8.decoder).join();

  var error;
  var data;
  if (resp.statusCode != 200) {
    error = json.decode(responseBody);
  }
  else {
    data = gameFromJson(responseBody);
  }

  return data;
}
