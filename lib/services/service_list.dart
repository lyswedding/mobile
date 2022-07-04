import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:lys_wedding/shared/urls.dart';

import '../../models/List_search.dart';

class ProviderCalls extends ChangeNotifier {
  final searchLists = <ServiceProvider>[];
  final favoriteSearchLists = <ServiceProvider>[];

  bool isProcessing = false;
  Future<List<ServiceProvider>> getPrestataire() async {
    searchLists.clear();
    var base_url = "http://102.219.178.96:3001/providers";
    isProcessing = true;
    final response = await http.get(Uri.parse('${base_url}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      for (var item in data['providers']) {
        var provider = ServiceProvider.fromJson(item);
        provider.cover = "http://102.219.178.96:3001" + provider.cover;
        List<String> imgs = [];
        for (var img in provider.images) {
          img = "http://102.219.178.96:3001" + img;
          imgs.add(img);
        }
        provider.images = imgs;
        searchLists.add(provider);
      }
    }
    isProcessing = false;
    notifyListeners();
    return searchLists;
  }

  Future<List<ServiceProvider>> getFavoritePrestataire(String id) async {
    favoriteSearchLists.clear();
    var base_url = "http://102.219.178.96:3001/providers/related/";
    final response = await http.get(Uri.parse('${base_url}' + id));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      for (var item in data['providers']) {
        var provider = ServiceProvider.fromJson(item);
        provider.cover = "http://102.219.178.96:3001" + provider.cover;
        List<String> imgs = [];
        for (var img in provider.images) {
          img = "http://102.219.178.96:3001" + img;
          imgs.add(img);
        }
        provider.images = imgs;
        favoriteSearchLists.add(provider);
      }
      print('zzzzzzzzzzzzzzzzzz');
      print(favoriteSearchLists);
    }
    return favoriteSearchLists;
  }
}
