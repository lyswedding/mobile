import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:lys_wedding/models/model_profil.dart';
import 'package:lys_wedding/services/dio_service.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:lys_wedding/shared/urls.dart';

class ServiceProfil {
  Future<UserApi> getUser() async {
    var dio = DioUtil.getInstance();

    var token = await getUserInfoSharedPref("token");

    dio.options.headers["Authorization"] = "Bearer " + token;
    return await dio.get(URLS.BASE_URL + '/users/me').then((value) {
      print(value.data);
      final data = jsonDecode(value.toString());
      print(data);

      return UserApi.fromJson(data);
    });
  }

  static Future updateUser(String Key, String value) async {
    UserApi userapi;
    var dio = DioUtil.getInstance();
    var response;
    var body = {Key: value};
    await getUserInfoSharedPref("token").then((token) async {
      dio.options.headers["Authorization"] = "Bearer " + token;
      return await dio
          .patch('${URLS.BASE_URL}/users/me', data: body)
          .then((value) {
        print(value.data);
        print(value.statusCode);

        response = value;
      });
    });

    return response.data;
    // if (response.statusCode == 200) {
    //   final data = json.decode(response.body);
    //   print(response.body);
    //   userapi = UserApi.fromJson(data);
    // } else {
    //   print(response.body);
    //
    //   throw Exception('not found');
    // }
    // return userapi;
  }

  static Future updateUserPassword(var body) async {
    UserApi userapi;
    var dio = DioUtil.getInstance();
    var response;
    var token = await getUserInfoSharedPref("token");

    //  .then((token) async
    //  {
    print(body);
    dio.options.headers["Authorization"] = "Bearer " + token;
    try {
      response = await dio.patch('${URLS.BASE_URL}/users/me', data: body);
      return response.data;
    } catch (e) {
      return null;
    }

    //     .then((value) {
    //   print(value.data);
    //   print(value.statusCode);

    //   response = value;
    // });

    // if (response.statusCode == 200) {
    //   final data = json.decode(response.body);
    //   print(response.body);
    //   userapi = UserApi.fromJson(data);
    // } else {
    //   print(response.body);

    //   throw Exception('not found');
    // }
    // return userapi;
  }

  static Future<String?> uploadImage(filepath, id) async {
    print(filepath);
    var token = await getUserInfoSharedPref('token');
    var request = http.MultipartRequest(
        'Put', Uri.parse('${URLS.BASE_URL}/users/upload/single'));
    request.fields['_id'] = id.toString();
    request.files.add(await http.MultipartFile.fromPath('image', filepath));
    request.headers['Authorization'] = "Bearer " + token;
    var res = await request.send();
    print(res.statusCode);
    print(res.reasonPhrase);
    return res.reasonPhrase;
  }
}
