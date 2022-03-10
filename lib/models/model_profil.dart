// To parse this JSON data, do
//
//     final userApi = userApiFromJson(jsonString);


import 'dart:convert';

UserApi userApiFromJson(String str) => UserApi.fromJson(json.decode(str));

class UserApi {
  UserApi({
    this.user,
    this.success,
  });

  User? user;
  bool? success;

  factory UserApi.fromJson(Map<String, dynamic> json) => UserApi(
        user: User.fromJson(json["user"]),
        success: json["success"],
      );
}

class User {
  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.type,
    this.password,
    this.tokenVersion,
    // required this.createdAt,
    ////this.updatedAt,
    //this.deletedAt,
    this.v,
    this.imageUrl,
  });

  final String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  String? type;
  String? password;
  int? tokenVersion;
  //DateTime createdAt;
  //dynamic updatedAt;
  //dynamic deletedAt;
  int? v;
  String? imageUrl;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"].toString(),
        email: json["email"].toString(),
        firstName: json["firstName"].toString(),
        lastName: json["lastName"].toString(),
        phone: json["phone"].toString(),
        type: json["type"].toString(),
        password: json["password"].toString(),
        tokenVersion: json["tokenVersion"],
        //createdAt: json["created_at"],
        //updatedAt: json["updated_at"],
        //deletedAt: json["deleted_at"],
        v: json["__v"],
        imageUrl: json["imageUrl"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "type": type,
        "password": password,
        "tokenVersion": tokenVersion,
        // "created_at": createdAt?.toIso8601String(),
        // "updated_at": updatedAt,
        // "deleted_at": deletedAt,
        "__v": v,
        "imageUrl": imageUrl,
      };
}
