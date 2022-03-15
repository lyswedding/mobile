import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lys_wedding/models/model_profil.dart';
import 'package:lys_wedding/services/dio_service.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:lys_wedding/shared/urls.dart';


class ServiceProfil {
  Future<UserApi> getUser() async {
    final profil = <User>[];
    UserApi userApi=UserApi();
    var dio = DioUtil.getInstance();

    var url = Uri.parse('${URLS.BASE_URL}/users/me');
    var token = await getUserInfoSharedPref("token");

    dio.options.headers["Authorization"] = "Bearer " + token;
    return  await dio.get(URLS.BASE_URL+'/providers/favorites').then((value){
      print(value.data);
      final data = jsonDecode(value.toString());
      print(data);

      return UserApi.fromJson(data);

    });
  }
}
