import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_igdb/models/gameSearch.dart';
import 'package:flutter_igdb/models/gameDetails.dart';
import 'package:flutter_igdb/models/pulses.dart';
import 'package:igdb_client/igdb_client.dart';

var client = new IGDBClient('amamildor', '66f9368c53abc2ef45b87aa438fa4076');

String url = 'https://api-v3.igdb.com';

Future<List<GameSearch>> getGames(String search) async {

  var params = new IGDBRequestParameters(
      search: search, //term to search
      fields: ['name', 'first_release_date', 'cover.*'], //fields to return from api call
      limit: 50 //nbMax of returned elements
  );

  final response = await makeRequest('$url/games', params.toBody()); //json return from api
  return gameSearchFromJson(response); //cast json to list of gameSearch
}

Future<List<GameSearch>> getFutureReleases() async {
  var date = (DateTime.now(). millisecondsSinceEpoch ~/ 1000).toInt();//(DateTime.now().millisecondsSinceEpoch / 1000).toInt()
  var params = new IGDBRequestParameters(
      fields: ['name', 'first_release_date', 'cover.*'], //fields to return from api call
      order: 'first_release_date asc',

      filters: 'release_dates.region = (1, 8) & first_release_date > $date & cover != null',
      limit: 50 //nbMax of returned elements
  );

  final response = await makeRequest('$url/games', params.toBody()); //json return from api
  return gameSearchFromJson(response); //cast json to list of gameSearch
}

Future<GameDetails> getGameDetails(int gameId) async {

  var params = new IGDBRequestParameters(
      ids: [gameId], //term to search
      fields: ['id', 'name', 'storyline', 'summary', 'aggregated_rating', 'aggregated_rating_count', 'screenshots.url', 'videos.*', 'websites.url', 'websites.category', 'category', 'cover.*', 'first_release_date', 'genres.*', 'involved_companies.company.name', 'involved_companies.company.logo.url', 'involved_companies.developer'], //fields to return from api call
  );

  final response = await makeRequest('$url/games', params.toBody()); //json return from api
  return gameDetailsFromJson(response).first; //cast json to list of gameSearch
}

Future<List<Pulses>> getPulses() async {

  var params = new IGDBRequestParameters(
    limit: 20,
    order: 'published_at desc',
    fields: ['author', 'created_at', 'image', 'published_at', 'pulse_source.name,summary', 'title', 'updated_at', 'website.url'], //fields to return from api call
  );

  final response = await makeRequest('$url/pulses', params.toBody()); //json return from api
  return pulsesFromJson(response); //cast json to list of gameSearch
}

Future<String> makeRequest(String url, String body) async {
  var uri = Uri.parse(url);
  var httpClient = new HttpClient();
  var request = await httpClient.postUrl(uri);
  request..headers.add('user-key', 'e1c0b81072bb92d9531ea3c1d686a56b')
    ..headers.add('User-Agent', 'amamildor')
    ..headers.add('Accept', 'application/json')
    ..write(body);

  var resp = await request.close();
  var responseBody = await resp.transform(utf8.decoder).join();

  /*var error;
  var data;
  if (resp.statusCode != 200) {
    error = json.decode(responseBody);
  }
  else {
    data = gameSearchFromJson(responseBody);
  }*/

  return responseBody;
}
