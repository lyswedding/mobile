import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:lys_wedding/models/List_search.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:lys_wedding/shared/urls.dart';
import 'package:http/http.dart' as http;

import 'dio_service.dart';

class FavoriteCalls {
  static Future addListToFavorite(id) async {
    Uri url;
    http.Response response;
    var dio = DioUtil.getInstance();

    url = Uri.parse('${URLS.BASE_URL}/taskslists/favorite/$id');

    var token = await getUserInfoSharedPref("token");
    dio.options.headers["Authorization"] = "Bearer " + token;
    return  await dio.putUri(url).then((value){
      return value;

    });

  }

  static Future addProviderToFavorite(id) async {
    Uri url;
    http.Response response;
    var dio = DioUtil.getInstance();

    url = Uri.parse('${URLS.BASE_URL}/providers/favorite/$id');

    var token = await getUserInfoSharedPref("token");
    dio.options.headers["Authorization"] = "Bearer " + token;
    return  await dio.putUri(url).then((value){
      print(value.data);
      return value;

    });
  }

  static Future deletTaskListFromFavorite(id) async {
    Uri url;
    http.Response response;
    var dio = DioUtil.getInstance();

    url = Uri.parse('${URLS.BASE_URL}/taskslists/favorite/$id');

    var token = await getUserInfoSharedPref("token");
    dio.options.headers["Authorization"] = "Bearer " + token;
    return  await dio.deleteUri(url).then((value){
      print(value.data);

      return value;
    });

  }

  static Future deletProviderFromFavorite(id) async {
    Uri url;
    http.Response response;
    var dio = DioUtil.getInstance();

    url = Uri.parse('${URLS.BASE_URL}/providers/favorite/$id');

    var token = await getUserInfoSharedPref("token");
    dio.options.headers["Authorization"] = "Bearer " + token;
    return  await dio.deleteUri(url).then((value){
      print(value.data);

      return value;
    });

  }

  static Future<List<Provider>> GetProvidersFavorite() async {
    Uri url;
    http.Response response;
    final favoriteProviders = <Provider>[];
    var dio = DioUtil.getInstance();

    url = Uri.parse('${URLS.BASE_URL}/providers/favorites');

    var token = await getUserInfoSharedPref("token");
    dio.options.headers["Authorization"] = "Bearer " + token;
//response will be assigned to response variable
    return  await dio.get(URLS.BASE_URL+'/providers/favorites').then((value){
      print(value.data);
      final data = jsonDecode(value.toString());
      print(data);
      for (var item in value.data['providers']) {
        favoriteProviders.add(Provider.fromJson(item));
      }
      return favoriteProviders.toList();

    });

  }


  static getFavorite()async{
    var dio = DioUtil.getInstance();
    List<TaskList> tasksLists=[];

    final String apiUrl = (URLS.BASE_URL + "/taskslists/favorites");
    var accessToken = await getUserInfoSharedPref('token');
    dio.options.headers["Authorization"] = "Bearer " + accessToken;
//response will be assigned to response variable
    return  await dio.get(apiUrl).then((value){
      print(value.data);
      final data = jsonDecode(value.toString());
      print(data);
      for (var item in value.data['tasksLists']) {
        tasksLists.add(TaskList.fromJson(item));
      }
      return tasksLists.toList();

    });
  }

}
