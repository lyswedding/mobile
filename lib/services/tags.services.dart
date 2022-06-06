import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lys_wedding/shared/urls.dart';
import 'package:http/http.dart' as http;

class TagsServices extends ChangeNotifier{

  bool isProcessing = true;
  final servicesLists = <String>[];

   Future<List<String>> getUniqueTags() async {
    var url;
    var response;
    isProcessing=true;
    url = Uri.parse('${URLS.BASE_URL}/taskslists/tags');
    response = await http.get(url, headers: {
      "Content-type": "application/json",
    });
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      for (var item in data['tags']) {
        servicesLists.add(item);
      }
    }
    isProcessing=false;
    notifyListeners();
    return servicesLists.toList();
  }


}