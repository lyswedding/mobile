import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lys_wedding/models/model_profil.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:lys_wedding/shared/urls.dart';


class ServiceProfil {
 // String base_url = "http://102.219.178.96:3001/users/621ccd6d8454fcf1f1280f4c";
  ServiceProfil() {}
  Future<UserApi> getUser() async {
    final profil = <User>[];
    UserApi userapi;
    var token = await getUserInfoSharedPref('token');
    final response = await http.get(Uri.parse('${URLS.BASE_URL}/users/me'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      print("jawk fesfes");
      final data = json.decode(response.body);
      print(data);
      //!
      userapi = UserApi.fromJson(data);
      // print("holaaaaaaaaaaa   " + userapi.user.lastName);
    } else {
      throw Exception('not found');
    }
    return userapi;
  }
}
