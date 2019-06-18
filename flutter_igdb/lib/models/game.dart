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
  List<int> releaseDates;

  Game({
    this.id,
    this.cover,
    this.firstReleaseDate,
    this.name,
    this.platforms,
    this.releaseDates,
  });

  factory Game.fromJson(Map<String, dynamic> json) => new Game(
    id: json["id"],
    cover: json["cover"] == null ? null : Cover.fromJson(json["cover"]),
    firstReleaseDate: json["first_release_date"] == null ? null : json["first_release_date"],
    name: json["name"],
    platforms: new List<Platform>.from(json["platforms"].map((x) => Platform.fromJson(x))),
    releaseDates: new List<int>.from(json["release_dates"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cover": cover == null ? null : cover.toJson(),
    "first_release_date": firstReleaseDate == null ? null : firstReleaseDate,
    "name": name,
    "platforms": new List<dynamic>.from(platforms.map((x) => x.toJson())),
    "release_dates": new List<dynamic>.from(releaseDates.map((x) => x)),
  };
}

class Cover {
  int id;
  bool alphaChannel;
  bool animated;
  int game;
  int height;
  String imageId;
  String url;
  int width;

  Cover({
    this.id,
    this.alphaChannel,
    this.animated,
    this.game,
    this.height,
    this.imageId,
    this.url,
    this.width,
  });

  factory Cover.fromJson(Map<String, dynamic> json) => new Cover(
    id: json["id"],
    alphaChannel: json["alpha_channel"] == null ? null : json["alpha_channel"],
    animated: json["animated"] == null ? null : json["animated"],
    game: json["game"] == null ? null : json["game"],
    height: json["height"],
    imageId: json["image_id"],
    url: json["url"],
    width: json["width"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "alpha_channel": alphaChannel == null ? null : alphaChannel,
    "animated": animated == null ? null : animated,
    "game": game == null ? null : game,
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
  int category;
  int createdAt;
  String name;
  Cover platformLogo;
  String slug;
  int updatedAt;
  String url;
  List<Version> versions;
  List<int> websites;
  int generation;
  int productFamily;
  String summary;

  Platform({
    this.id,
    this.abbreviation,
    this.alternativeName,
    this.category,
    this.createdAt,
    this.name,
    this.platformLogo,
    this.slug,
    this.updatedAt,
    this.url,
    this.versions,
    this.websites,
    this.generation,
    this.productFamily,
    this.summary,
  });

  factory Platform.fromJson(Map<String, dynamic> json) => new Platform(
    id: json["id"],
    abbreviation: json["abbreviation"],
    alternativeName: json["alternative_name"] == null ? null : json["alternative_name"],
    category: json["category"],
    createdAt: json["created_at"],
    name: json["name"],
    platformLogo: json["platform_logo"] == null ? null : Cover.fromJson(json["platform_logo"]),
    slug: json["slug"],
    updatedAt: json["updated_at"],
    url: json["url"],
    versions: new List<Version>.from(json["versions"].map((x) => Version.fromJson(x))),
    websites: json["websites"] == null ? null : new List<int>.from(json["websites"].map((x) => x)),
    generation: json["generation"] == null ? null : json["generation"],
    productFamily: json["product_family"] == null ? null : json["product_family"],
    summary: json["summary"] == null ? null : json["summary"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "abbreviation": abbreviation,
    "alternative_name": alternativeName == null ? null : alternativeName,
    "category": category,
    "created_at": createdAt,
    "name": name,
    "platform_logo": platformLogo == null ? null : platformLogo.toJson(),
    "slug": slug,
    "updated_at": updatedAt,
    "url": url,
    "versions": new List<dynamic>.from(versions.map((x) => x.toJson())),
    "websites": websites == null ? null : new List<dynamic>.from(websites.map((x) => x)),
    "generation": generation == null ? null : generation,
    "product_family": productFamily == null ? null : productFamily,
    "summary": summary == null ? null : summary,
  };
}

class Version {
  int id;
  String name;
  int platformLogo;
  List<int> platformVersionReleaseDates;
  String slug;
  String summary;
  String url;
  String cpu;
  String media;
  String output;
  String sound;
  String storage;
  String graphics;
  String resolutions;
  String memory;
  String online;
  List<int> companies;
  String connectivity;
  int mainManufacturer;
  String os;

  Version({
    this.id,
    this.name,
    this.platformLogo,
    this.platformVersionReleaseDates,
    this.slug,
    this.summary,
    this.url,
    this.cpu,
    this.media,
    this.output,
    this.sound,
    this.storage,
    this.graphics,
    this.resolutions,
    this.memory,
    this.online,
    this.companies,
    this.connectivity,
    this.mainManufacturer,
    this.os,
  });

  factory Version.fromJson(Map<String, dynamic> json) => new Version(
    id: json["id"],
    name: json["name"],
    platformLogo: json["platform_logo"] == null ? null : json["platform_logo"],
    platformVersionReleaseDates: json["platform_version_release_dates"] == null ? null : new List<int>.from(json["platform_version_release_dates"].map((x) => x)),
    slug: json["slug"],
    summary: json["summary"] == null ? null : json["summary"],
    url: json["url"],
    cpu: json["cpu"] == null ? null : json["cpu"],
    media: json["media"] == null ? null : json["media"],
    output: json["output"] == null ? null : json["output"],
    sound: json["sound"] == null ? null : json["sound"],
    storage: json["storage"] == null ? null : json["storage"],
    graphics: json["graphics"] == null ? null : json["graphics"],
    resolutions: json["resolutions"] == null ? null : json["resolutions"],
    memory: json["memory"] == null ? null : json["memory"],
    online: json["online"] == null ? null : json["online"],
    companies: json["companies"] == null ? null : new List<int>.from(json["companies"].map((x) => x)),
    connectivity: json["connectivity"] == null ? null : json["connectivity"],
    mainManufacturer: json["main_manufacturer"] == null ? null : json["main_manufacturer"],
    os: json["os"] == null ? null : json["os"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "platform_logo": platformLogo == null ? null : platformLogo,
    "platform_version_release_dates": platformVersionReleaseDates == null ? null : new List<dynamic>.from(platformVersionReleaseDates.map((x) => x)),
    "slug": slug,
    "summary": summary == null ? null : summary,
    "url": url,
    "cpu": cpu == null ? null : cpu,
    "media": media == null ? null : media,
    "output": output == null ? null : output,
    "sound": sound == null ? null : sound,
    "storage": storage == null ? null : storage,
    "graphics": graphics == null ? null : graphics,
    "resolutions": resolutions == null ? null : resolutions,
    "memory": memory == null ? null : memory,
    "online": online == null ? null : online,
    "companies": companies == null ? null : new List<dynamic>.from(companies.map((x) => x)),
    "connectivity": connectivity == null ? null : connectivity,
    "main_manufacturer": mainManufacturer == null ? null : mainManufacturer,
    "os": os == null ? null : os,
  };
}
