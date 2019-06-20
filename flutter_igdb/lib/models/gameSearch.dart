// To parse this JSON data, do
//
//     final gameSearch = gameSearchFromJson(jsonString);

import 'dart:convert';

List<GameSearch> gameSearchFromJson(String str) => new List<GameSearch>.from(json.decode(str).map((x) => GameSearch.fromJson(x)));

String gameSearchToJson(List<GameSearch> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class GameSearch {
  int id;
  Cover cover;
  int firstReleaseDate;
  String name;

  GameSearch({
    this.id,
    this.cover,
    this.firstReleaseDate,
    this.name,
  });

  factory GameSearch.fromJson(Map<String, dynamic> json) => new GameSearch(
    id: json["id"],
    cover: json["cover"] == null ? null : Cover.fromJson(json["cover"]),
    firstReleaseDate: json["first_release_date"] == null ? null : json["first_release_date"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cover": cover == null ? null : cover.toJson(),
    "first_release_date": firstReleaseDate == null ? null : firstReleaseDate,
    "name": name,
  };
}

class Cover {
  int id;
  int game;
  int height;
  String imageId;
  String url;
  int width;
  bool alphaChannel;
  bool animated;

  Cover({
    this.id,
    this.game,
    this.height,
    this.imageId,
    this.url,
    this.width,
    this.alphaChannel,
    this.animated,
  });

  factory Cover.fromJson(Map<String, dynamic> json) => new Cover(
    id: json["id"],
    game: json["game"],
    height: json["height"],
    imageId: json["image_id"],
    url: json["url"],
    width: json["width"],
    alphaChannel: json["alpha_channel"] == null ? null : json["alpha_channel"],
    animated: json["animated"] == null ? null : json["animated"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "game": game,
    "height": height,
    "image_id": imageId,
    "url": url,
    "width": width,
    "alpha_channel": alphaChannel == null ? null : alphaChannel,
    "animated": animated == null ? null : animated,
  };
}
