import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:lys_wedding/models/model_profil.dart';

import '../../../../../shared/sharedPrefValues.dart';
import '../../../../../shared/urls.dart';

class ServiceProfilModif {
  ServiceProfilModif() {}
  static Future<UserApi> updateUser(String Key, String value) async {
    final profil = <User>[];
    UserApi userapi;
    var url = Uri.parse('${URLS.BASE_URL}/users/me');
    var token = await getUserInfoSharedPref("token");

    final response = await http.put(url, headers: {
      'Authorization': 'Bearer $token ',
    }, body: {
      Key = value
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(response.body);
      userapi = UserApi.fromJson(data);
    } else {
      print(response.body);

      throw Exception('not found');
    }
    return userapi;
  }
}
