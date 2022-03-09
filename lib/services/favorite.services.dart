import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:lys_wedding/models/List_search.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:lys_wedding/shared/urls.dart';
import 'package:http/http.dart' as http;

class FavoriteCalls {

  static Future<http.Response> addListToFavorite(id) async {
    var url;
    var response;

    url = Uri.parse('${URLS.BASE_URL}/taskslists/favorite/$id');

    var token = await getUserInfoSharedPref("token");
    response = await http.put(
      url,
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    return response.body;
  }

  static Future<http.Response> addProviderToFavorite(id) async {
    var url;
    var response;

    url = Uri.parse('${URLS.BASE_URL}/providers/favorite/$id');

    var token = await getUserInfoSharedPref("token");
    response = await http.put(
      url,
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    return response.body;
  }
  static Future<http.Response> deletTaskListFromFavorite(id) async {
    var url;
    var response;

    url = Uri.parse('${URLS.BASE_URL}/taskslists/favorite/$id');

    var token = await getUserInfoSharedPref("token");
    response = await http.delete(
      url,
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    return response.body;
  }

  static Future<http.Response> deletProviderFromFavorite(id) async {
    var url;
    var response;

    url = Uri.parse('${URLS.BASE_URL}/providers/favorite/$id');

    var token = await getUserInfoSharedPref("token");
    response = await http.delete(
      url,
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    return response.body;
  }

  static Future<List<Provider>> GetProvidersFavorite() async {
    var url;
    var response;
    final favoriteProviders = <Provider>[];

    url = Uri.parse('${URLS.BASE_URL}/providers/favorites');

    var token = await getUserInfoSharedPref("token");
    response = await http.get(
      url,
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(response.body);
      for (var item in data['providers']) {
        favoriteProviders.add(Provider.fromJson(item));
      }
    }
    return favoriteProviders.toList();
  }
  static Future<List<TaskList>> GetTaskListFavorite() async {
    var url;
    var response;
    final tasksLists = <TaskList>[];

    url = Uri.parse('${URLS.BASE_URL}/taskslists/favorites');

    var token = await getUserInfoSharedPref("token");
    response = await http.get(
      url,
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      for (var item in data['tasksLists']) {
        if(item!=null)
          print(item["tasks"]);
        tasksLists.add(TaskList.fromJson(item));
      }
    }
    return tasksLists.toList();
  }

}
