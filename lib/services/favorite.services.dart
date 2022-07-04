import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:lys_wedding/models/List_search.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:lys_wedding/shared/urls.dart';
import 'package:http/http.dart' as http;

import 'dio_service.dart';

class FavoriteCalls extends ChangeNotifier{
  final favoriteProviders = <ServiceProvider>[];
  final favoriteProvidersId = <String>[];
  final favoriteList = <TaskList>[];
  final favoriteListId = <String>[];
  bool isProcessing = false;

  static Future addListToFavorite(id) async {
    Uri url;
    http.Response response;
    var dio = DioUtil.getInstance();

    url = Uri.parse('${URLS.BASE_URL}/taskslists/favorite/$id');

    var token = await getUserInfoSharedPref("token");
    dio.options.headers["Authorization"] = "Bearer " + token;
    return await dio.putUri(url).then((value) {
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
    return await dio.putUri(url).then((value) {
      print("zzzzzzzzzzzzzzzzzzzzzz");
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
    return await dio.deleteUri(url).then((value) {
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
    return await dio.deleteUri(url).then((value) {
      print(value.data);

      return value;
    });
  }

  Future<List<ServiceProvider>> GetProvidersFavorite() async {
    Uri url;
    http.Response response;
    var dio = DioUtil.getInstance();
    favoriteProviders.clear();
    isProcessing = true;
    url = Uri.parse('${URLS.BASE_URL}/providers/favorites');

    var token = await getUserInfoSharedPref("token");
    dio.options.headers["Authorization"] = "Bearer " + token;
//response will be assigned to response variable
    return await dio.get(URLS.BASE_URL + '/providers/favorites').then((value) {
      print(value.data);
      final data = jsonDecode(value.toString());
      print(data);
      for (var item in data['providers']) {
        print("aaaaaaaaaaaaa");
        var provider = ServiceProvider.fromJson(item);
        provider.cover = "http://102.219.178.96:3001" + provider.cover;
        List<String> imgs = [];
        for (var img in provider.images) {
          img = "http://102.219.178.96:3001" + img;
          imgs.add(img);
        }
        provider.images = imgs;
        favoriteProviders.add(provider);
        favoriteProvidersId.add(provider.id);
        print(favoriteProviders);
      }
      // for (var item in value.data['providers']) {
      //   if (item != null) {
      //     favoriteProviders.add(Provider.fromJson(item));
      //   }
      // }
      isProcessing=false;
      notifyListeners();
      return favoriteProviders.toList();
    });
  }

   Future<List<TaskList>> getFavorite() async {
    favoriteList.clear();
    Uri url;
    http.Response response;
    isProcessing=true;
    var dio = DioUtil.getInstance();

    url = Uri.parse('${URLS.BASE_URL}/taskslists/favorites');
    var token = await getUserInfoSharedPref("token");
    dio.options.headers["Authorization"] = "Bearer " + token;
    return await dio.get(URLS.BASE_URL + '/taskslists/favorites').then((value) {
      for (var item in value.data['tasksLists']) {
        if (item != null) {
          favoriteList.add(TaskList.fromJson(item));
          favoriteListId.add(TaskList.fromJson(item).id!);
        }
      }
      isProcessing=false;
      notifyListeners();
      return favoriteList.toList();
    });
  }
}
