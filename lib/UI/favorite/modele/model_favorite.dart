// To parse this JSON data, do
//
//     final favoriteApi = favoriteApiFromJson(jsonString);

import 'dart:convert';

FavoriteApi favoriteApiFromJson(String str) =>
    FavoriteApi.fromJson(json.decode(str));

String favoriteApiToJson(FavoriteApi data) => json.encode(data.toJson());

class FavoriteApi {
  FavoriteApi({
    required this.providers,
    required this.success,
  });

  List<ProviderElement> providers;
  bool success;

  factory FavoriteApi.fromJson(Map<String, dynamic> json) => FavoriteApi(
        providers: List<ProviderElement>.from(
            json["providers"].map((x) => ProviderElement.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "providers": List<dynamic>.from(providers.map((x) => x.toJson())),
        "success": success,
      };
}

class ProviderElement {
  ProviderElement({
    required this.id,
    required this.provider,
    required this.user,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.v,
  });

  String id;
  ProviderProvider provider;
  String user;
  DateTime createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  int v;

  factory ProviderElement.fromJson(Map<String, dynamic> json) =>
      ProviderElement(
        id: json["_id"],
        provider: ProviderProvider.fromJson(json["provider"]),
        user: json["user"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "provider": provider.toJson(),
        "user": user,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "__v": v,
      };
}

class ProviderProvider {
  ProviderProvider({
    required this.id,
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
    required this.updatedAt,
    required this.deletedAt,
    required this.v,
    required this.images,
    required this.websiteUrl,
  });

  String id;
  String name;
  String cover;
  String description;
  String phone;
  String email;
  String facebookUrl;
  String instagramUrl;
  List<String> services;
  List<String> locations;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int v;
  List<String> images;
  String websiteUrl;

  factory ProviderProvider.fromJson(Map<String, dynamic> json) =>
      ProviderProvider(
        id: json["_id"],
        name: json["name"],
        cover: json["cover"],
        description: json["description"],
        phone: json["phone"],
        email: json["email"],
        facebookUrl: json["facebookUrl"],
        instagramUrl: json["instagramUrl"],
        services: List<String>.from(json["services"].map((x) => x)),
        locations: List<String>.from(json["locations"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        v: json["__v"],
        images: List<String>.from(json["images"].map((x) => x)),
        websiteUrl: json["websiteUrl"],
      );

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
        "locations": List<dynamic>.from(locations.map((x) => x)),
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
        "deleted_at": deletedAt,
        "__v": v,
        "images": List<dynamic>.from(images.map((x) => x)),
        "websiteUrl": websiteUrl,
      };
}
