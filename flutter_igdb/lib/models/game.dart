// To parse this JSON data, do
//
//     final game = gameFromJson(jsonString);

import 'dart:convert';

List<Game> gameFromJson(String str) => new List<Game>.from(json.decode(str).map((x) => Game.fromJson(x)));

String gameToJson(List<Game> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Game {
  int id;
  Cover cover;
  int firstReleaseDate;
  String name;
  List<Platform> platforms;

  Game({
    this.id,
    this.cover,
    this.firstReleaseDate,
    this.name,
    this.platforms,
  });

  factory Game.fromJson(Map<String, dynamic> json) => new Game(
    id: json["id"],
    cover: json["cover"] == null ? null : Cover.fromJson(json["cover"]),
    firstReleaseDate: json["first_release_date"] == null ? null : json["first_release_date"],
    name: json["name"],
    platforms: json["platforms"] == null ? null : new List<Platform>.from(json["platforms"].map((x) => Platform.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cover": cover.toJson(),
    "first_release_date": firstReleaseDate == null ? null : firstReleaseDate,
    "name": name,
    "platforms": platforms == null ? null : new List<dynamic>.from(platforms.map((x) => x.toJson())),
  };
}

class Cover {
  int id;
  int height;
  String imageId;
  String url;
  int width;

  Cover({
    this.id,
    this.height,
    this.imageId,
    this.url,
    this.width,
  });

  factory Cover.fromJson(Map<String, dynamic> json) => new Cover(
    height: json["height"],
    imageId: json["image_id"],
    url: json["url"],
    width: json["width"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "height": height,
    "image_id": imageId,
    "url": url,
    "width": width,
  };
}

class Platform {
  int id;
  String abbreviation;
  String alternativeName;
  String name;
  PlatformLogo platformLogo;
  List<Version> versions;

  Platform({
    this.id,
    this.abbreviation,
    this.alternativeName,
    this.name,
    this.platformLogo,
    this.versions,
  });

  factory Platform.fromJson(Map<String, dynamic> json) => new Platform(
    id: json["id"],
    abbreviation: json["abbreviation"],
    alternativeName: json["alternative_name"],
    name: json["name"],
    platformLogo: json["platform_logo"] == null ? null : PlatformLogo.fromJson(json["platform_logo"]),
    versions: new List<Version>.from(json["versions"].map((x) => Version.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "abbreviation": abbreviation,
    "alternative_name": alternativeName,
    "name": name,
    "platform_logo": platformLogo == null ? null : platformLogo.toJson(),
    "versions": new List<dynamic>.from(versions.map((x) => x.toJson())),
  };
}

class PlatformLogo {
  int id;
  String url;

  PlatformLogo({
    this.id,
    this.url,
  });

  factory PlatformLogo.fromJson(Map<String, dynamic> json) => new PlatformLogo(
    id: json["id"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
  };
}

class Version {
  int id;
  String name;
  PlatformLogo platformLogo;

  Version({
    this.id,
    this.name,
    this.platformLogo,
  });

  factory Version.fromJson(Map<String, dynamic> json) => new Version(
    id: json["id"],
    name: json["name"],
    platformLogo: json["platform_logo"] == null ? null : json["platform_logo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "platform_logo": platformLogo == null ? null : platformLogo,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
