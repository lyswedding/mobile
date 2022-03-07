import 'dart:convert';
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
      String token = json.decode(response.headers.toString())['token'];
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      //debugPrint(decodedToken.toString());
      String userid = decodedToken['subject']['_id'];
      await saveAccessTokenSharedPref(token, userid);
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

  static Future<int?> signup(body) async {
    var url;
    url = '${URLS.BASE_URL}/users/register';

    Dio dio = Dio();
    var formData = FormData();

    List<MapEntry<String, String>> mapEntries = [
      MapEntry("name", body['firstname']),
      MapEntry("lastname", body['lastname']),
      MapEntry("phone", body['phone']),
      MapEntry("email", body['email']),
      MapEntry("password", body['password']),
    ];

    formData.fields.addAll(mapEntries);

    var awsResponse = await dio.post(
      url,
      options: Options(
          contentType: 'multipart/form-data',
          headers: {
            "accept": "*/*",
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! <= 500;
          }),
      data: formData,
    );
    print(awsResponse.statusCode);
    debugPrint(awsResponse.data.toString());
    return awsResponse.statusCode;
  }
}
