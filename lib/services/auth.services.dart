import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:lys_wedding/shared/urls.dart';

class AuthCalls {
  static Future<http.Response> login(body) async {
    var url;
    url = Uri.parse('${URLS.BASE_URL}/users/login');

    final response = await http.post(url,
        body: jsonEncode(body), headers: {"Content-type": "application/json"});
    print(jsonEncode(body));

    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      log(response.headers['x-access-token'].toString());
      String token = response.headers['x-access-token'].toString();
      String cookie = response.headers['set-cookie'].toString();
      print(token);
      print(cookie);
      // Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      // //debugPrint(decodedToken.toString());
      // String userid = decodedToken['subject']['_id'];
      await saveAccessTokenSharedPref(token,cookie);
    }

    return response;
  }

  static Future<http.Response> getUserInfo() async {
    var url;
    var response;

    await getUserInfoSharedPref("userid").then((id) async {
      url = Uri.parse('${URLS.BASE_URL}/users/$id');

      await getUserInfoSharedPref("token").then((token) async {
        response = await http.get(url, headers: {
          "Content-type": "application/json",
          'Authorization': 'Bearer $token',
        });
      });
    });

    if (response.statusCode == 200) {
      debugPrint(response.body);
    }
    return response;
  }

  static Future<int> signup(body) async {
    var url;
    url = '${URLS.BASE_URL}/users/register';

    final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(body));
    if (response.statusCode == 201) {
      String token = response.headers['x-access-token'].toString();
      String cookie = response.headers['set-cookie'].toString();
      print(token);
      print('**********cookie*********');
      print(cookie);
      // Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      // //debugPrint(decodedToken.toString());
      // String userid = decodedToken['subject']['_id'];
      await saveAccessTokenSharedPref(token,cookie);
      return response.statusCode;
    } else {
      print(response.body);
      throw Exception('exception occured!!!!!!');
    }
  }
}
