// To parse this JSON data, do
//
//     final listSearch = listSearchFromJson(jsonString);

import 'dart:convert';

ListSearch listSearchFromJson(String str) =>
    ListSearch.fromJson(json.decode(str));

String listSearchToJson(ListSearch data) => json.encode(data.toJson());

class ListSearch {
  ListSearch({
    required this.providers,
    required this.success,
  });

  List<Provider> providers;
  bool success;

  factory ListSearch.fromJson(Map<String, dynamic> json) => ListSearch(
        providers: List<Provider>.from(
            json["providers"].map((x) => Provider.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "providers": List<dynamic>.from(providers.map((x) => x.toJson())),
        "success": success,
      };
}

class Provider {
  Provider(
      {required this.id,
      required this.name,
      required this.cover,
      required this.description,
      required this.phone,
      required this.email,
      required this.facebookUrl,
      required this.instagramUrl,
      required this.services,
      required this.locations,
      required this.createdAt,
      this.updatedAt,
      this.deletedAt,
      required this.v,
      required this.images});

  String id;
  String name;
  String cover;
  String description;
  String phone;
  String email;
  String facebookUrl;
  String instagramUrl;
  List<dynamic> services;
  List<Location> locations;
  DateTime createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  int v;
  List<String> images;

  factory Provider.fromJson(Map<String, dynamic> json) {
    var lists = json['locations'] as List;

    List<Location> locations = lists.map((i) => Location.fromJson(i)).toList();
    return Provider(
        id: json["_id"],
        name: json["name"],
        cover: json["cover"],
        description: json["description"],
        phone: json["phone"],
        email: json["email"],
        facebookUrl: json["facebookUrl"],
        instagramUrl: json["instagramUrl"],
        services: List<dynamic>.from(json["services"].map((x) => x)),
        locations: locations,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        v: json["__v"],
        images: List<String>.from(json["images"].map((x) => x)));
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "cover": cover,
        "description": description,
        "phone": phone,
        "email": email,
        "facebookUrl": facebookUrl,
        "instagramUrl": instagramUrl,
        "services": List<dynamic>.from(services.map((x) => x)),
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "__v": v,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}

class Location {
  Location({
    this.id,
    this.address,
    this.lat,
    this.long,
    this.place,
  });

  String? id;
  String? address;
  String? lat;
  String? long;
  dynamic place;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["_id"],
        address: json["address"],
        lat: json["lat"],
        long: json["long"],
        place: json["place"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "address": address,
        "lat": lat,
        "long": long,
        "place": place,
      };
}
