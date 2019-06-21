// To parse this JSON data, do
//
//     final gameDetails = gameDetailsFromJson(jsonString);

import 'dart:convert';

List<GameDetails> gameDetailsFromJson(String str) => new List<GameDetails>.from(json.decode(str).map((x) => GameDetails.fromJson(x)));

String gameDetailsToJson(List<GameDetails> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class GameDetails {
  int id;
  double aggregatedRating;
  int aggregatedRatingCount;
  int category;
  Cover cover;
  int firstReleaseDate;
  List<Genre> genres;
  List<InvolvedCompany> involvedCompanies;
  String name;
  List<Screenshot> screenshots;
  String storyline;
  String summary;
  List<Video> videos;
  List<Screenshot> websites;

  GameDetails({
    this.id,
    this.aggregatedRating,
    this.aggregatedRatingCount,
    this.category,
    this.cover,
    this.firstReleaseDate,
    this.genres,
    this.involvedCompanies,
    this.name,
    this.screenshots,
    this.storyline,
    this.summary,
    this.videos,
    this.websites,
  });

  factory GameDetails.fromJson(Map<String, dynamic> json) => new GameDetails(
    id: json["id"],
    aggregatedRating: json["aggregated_rating"].toDouble(),
    aggregatedRatingCount: json["aggregated_rating_count"],
    category: json["category"],
    cover: Cover.fromJson(json["cover"]),
    firstReleaseDate: json["first_release_date"],
    genres: new List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
    involvedCompanies: new List<InvolvedCompany>.from(json["involved_companies"].map((x) => InvolvedCompany.fromJson(x))),
    name: json["name"],
    screenshots: new List<Screenshot>.from(json["screenshots"].map((x) => Screenshot.fromJson(x))),
    storyline: json["storyline"],
    summary: json["summary"],
    videos: new List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
    websites: new List<Screenshot>.from(json["websites"].map((x) => Screenshot.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "aggregated_rating": aggregatedRating,
    "aggregated_rating_count": aggregatedRatingCount,
    "category": category,
    "cover": cover.toJson(),
    "first_release_date": firstReleaseDate,
    "genres": new List<dynamic>.from(genres.map((x) => x.toJson())),
    "involved_companies": new List<dynamic>.from(involvedCompanies.map((x) => x.toJson())),
    "name": name,
    "screenshots": new List<dynamic>.from(screenshots.map((x) => x.toJson())),
    "storyline": storyline,
    "summary": summary,
    "videos": new List<dynamic>.from(videos.map((x) => x.toJson())),
    "websites": new List<dynamic>.from(websites.map((x) => x.toJson())),
  };
}

class Cover {
  int id;
  int game;
  int height;
  String imageId;
  String url;
  int width;

  Cover({
    this.id,
    this.game,
    this.height,
    this.imageId,
    this.url,
    this.width,
  });

  factory Cover.fromJson(Map<String, dynamic> json) => new Cover(
    id: json["id"],
    game: json["game"],
    height: json["height"],
    imageId: json["image_id"],
    url: json["url"],
    width: json["width"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "game": game,
    "height": height,
    "image_id": imageId,
    "url": url,
    "width": width,
  };
}

class Genre {
  int id;
  int createdAt;
  String name;
  String slug;
  int updatedAt;
  String url;

  Genre({
    this.id,
    this.createdAt,
    this.name,
    this.slug,
    this.updatedAt,
    this.url,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => new Genre(
    id: json["id"],
    createdAt: json["created_at"],
    name: json["name"],
    slug: json["slug"],
    updatedAt: json["updated_at"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt,
    "name": name,
    "slug": slug,
    "updated_at": updatedAt,
    "url": url,
  };
}

class InvolvedCompany {
  int id;
  Company company;
  bool developer;

  InvolvedCompany({
    this.id,
    this.company,
    this.developer,
  });

  factory InvolvedCompany.fromJson(Map<String, dynamic> json) => new InvolvedCompany(
    id: json["id"],
    company: Company.fromJson(json["company"]),
    developer: json["developer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company": company.toJson(),
    "developer": developer,
  };
}

class Company {
  int id;
  Screenshot logo;
  String name;

  Company({
    this.id,
    this.logo,
    this.name,
  });

  factory Company.fromJson(Map<String, dynamic> json) => new Company(
    id: json["id"],
    logo: Screenshot.fromJson(json["logo"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "logo": logo.toJson(),
    "name": name,
  };
}

class Screenshot {
  int id;
  String url;

  Screenshot({
    this.id,
    this.url,
  });

  factory Screenshot.fromJson(Map<String, dynamic> json) => new Screenshot(
    id: json["id"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
  };
}

class Video {
  int id;
  int game;
  String name;
  String videoId;

  Video({
    this.id,
    this.game,
    this.name,
    this.videoId,
  });

  factory Video.fromJson(Map<String, dynamic> json) => new Video(
    id: json["id"],
    game: json["game"],
    name: json["name"],
    videoId: json["video_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "game": game,
    "name": name,
    "video_id": videoId,
  };
}
