// To parse this JSON data, do
//
//     final authSm = authSmFromJson(jsonString);

import 'dart:convert';

AuthSm authSmFromJson(String str) => AuthSm.fromJson(json.decode(str));

String authSmToJson(AuthSm data) => json.encode(data.toJson());

class AuthSm {
  AuthSm({
    this.email,
    this.firstName,
    this.lastName,
    this.imageUrl,
    this.googleId,
    this.facebookId,
  });

  String? email;
  String? firstName;
  String? lastName;
  String? imageUrl;
  String? googleId;
  String? facebookId;

  factory AuthSm.fromJson(Map<String, dynamic> json) => AuthSm(
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        imageUrl: json["imageUrl"],
        googleId: json["googleId"],
        facebookId: json["facebookId"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "imageUrl": imageUrl,
        "googleId": googleId,
        "facebookId": facebookId,
      };
}
