import 'dart:convert';

import 'package:lys_wedding/models/auth_sm_model.dart';
import 'package:lys_wedding/models/insert_user.dart';
import 'package:lys_wedding/shared/urls.dart';
import 'package:http/http.dart' as http;

class AuthSmService {
  Future<AuthSm?> authGoogles(
      String email, String firstName, String imageUrl, String? googleId) async {
    var url;
    url = Uri.parse('${URLS.BASE_URL}/users/auth/login-sm');
    print("hahahahh");
    final response = await http.post(url,
        body: jsonEncode({
          "email": email,
          "firstName": firstName,
          "imageUrl": imageUrl,
          "googleId": googleId
        }),
        headers: {"Content-type": "application/json"});

    print("aaaazzzzzzzzzzzzzaaaaaaaaaaaa");
    if (response.statusCode == 200) {
      print("");
      final String res = response.body;
      return authSmFromJson(res);
    }
  }

  Future<AuthSm?> authfacebook(String email, String firstName, String imageUrl,
      String facebookId) async {
    var url;
    url = Uri.parse('${URLS.BASE_URL}/users/auth/login-sm');
    print("aaaaa");
    final response = await http.post(url,
        body: jsonEncode({
          "email": email,
          "firstName": firstName,
          "imageUrl": imageUrl,
          "facebookId": facebookId
        }),
        headers: {"Content-type": "application/json"});
    print("aaaazzzzzzzzzzzzzaaaaaaaaaaaa");
    if (response.statusCode == 200) {
      print("aaaazzzzzzzzzzzzza");
      final String res = response.body;
      return authSmFromJson(res);
    } else {
      print("errer");
      return null;
    }
  }
}
