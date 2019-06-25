// To parse this JSON data, do
//
//     final pulses = pulsesFromJson(jsonString);

import 'dart:convert';

List<Pulses> pulsesFromJson(String str) => new List<Pulses>.from(json.decode(str).map((x) => Pulses.fromJson(x)));

String pulsesToJson(List<Pulses> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Pulses {
  int id;
  String author;
  int createdAt;
  String image;
  int publishedAt;
  PulseSource pulseSource;
  String summary;
  String title;
  int updatedAt;
  Website website;

  Pulses({
    this.id,
    this.author,
    this.createdAt,
    this.image,
    this.publishedAt,
    this.pulseSource,
    this.summary,
    this.title,
    this.updatedAt,
    this.website,
  });

  factory Pulses.fromJson(Map<String, dynamic> json) => new Pulses(
    id: json["id"],
    author: json["author"],
    createdAt: json["created_at"],
    image: json["image"],
    publishedAt: json["published_at"],
    pulseSource: PulseSource.fromJson(json["pulse_source"]),
    summary: json["summary"],
    title: json["title"],
    updatedAt: json["updated_at"],
    website: Website.fromJson(json["website"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "author": author,
    "created_at": createdAt,
    "image": image,
    "published_at": publishedAt,
    "pulse_source": pulseSource.toJson(),
    "summary": summary,
    "title": title,
    "updated_at": updatedAt,
    "website": website.toJson(),
  };
}

class PulseSource {
  int id;
  String name;

  PulseSource({
    this.id,
    this.name,
  });

  factory PulseSource.fromJson(Map<String, dynamic> json) => new PulseSource(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Website {
  int id;
  String url;

  Website({
    this.id,
    this.url,
  });

  factory Website.fromJson(Map<String, dynamic> json) => new Website(
    id: json["id"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
  };
}
