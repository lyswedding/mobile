import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:lys_wedding/shared/urls.dart';
import 'package:http/http.dart' as http;

import 'dio_service.dart';

class ListCalls {

  static Future<List<TaskList>> getAdminLists() async {
    var url;
    var response;
    final tasksLists = <TaskList>[];
    url = Uri.parse('${URLS.BASE_URL}/taskslists');
    response = await http.get(url, headers: {
      "Content-type": "application/json",
    });
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('*****************admiiin**************');
      print(data);
      for (var item in data['tasksLists']) {
        tasksLists.add(TaskList.fromJson(item));
      }
    }
    return tasksLists.toList();
  }


  static Future addTaskList(TaskList task) async {
    var url;
    var response;
    var dio = DioUtil.getInstance();


    url = Uri.parse('${URLS.BASE_URL}/taskslists');
    var request = http.MultipartRequest('POST', url);
    var token = await getUserInfoSharedPref("token");
    dio.options.headers["Authorization"] = "Bearer " + token;

    return  await dio.post('${URLS.BASE_URL}/taskslists',data:task.toJson()).then((value){
      print(value.data);
      return value;
    });

  }


  static jsonToFormData(http.MultipartRequest request,Map<String, dynamic> data) {
    for (var key in data.keys) {

      request.fields[key] = data[key].toString();
      print(data[key].toString());
    }
    print(request.fields['tasks']);
    return request.fields;
  }


  static Future<TaskList> editTaskInList(Task task,idTask,idTaskList) async {
    var url;
    var response;
    var dio = DioUtil.getInstance();

     url = Uri.parse('${URLS.BASE_URL}/taskslists/$idTaskList/task/$idTask');

      await getUserInfoSharedPref("token").then((token) async {
        dio.options.headers["Authorization"] = "Bearer " + token;
        return  await dio.patch(url.toString(),data: jsonEncode(task.toJson())).then((value){
          print(value.data);
          response= value;

        });
      });
    return response;

  }

  static Future<TaskList> editList(TaskList task,idTaskList) async {
    var url;
    var response;
    var dio = DioUtil.getInstance();

    url = Uri.parse('${URLS.BASE_URL}/taskslists/$idTaskList');
    await getUserInfoSharedPref("token").then((token) async {
      print(task.toJson());
      dio.options.headers["Authorization"] = "Bearer " + token;
      return  await dio.patch('${URLS.BASE_URL}/taskslists/$idTaskList',data:task.toJson()).then((value){
        print(value.data);
        response= value;

      });
    });
    return response;

  }

  static Future<http.Response> deletTaskListFromTaskList(idList,idTask) async {
    var url;
    var response;
    var dio = DioUtil.getInstance();

    url = Uri.parse('${URLS.BASE_URL}/taskslists/$idList/task/$idTask');

    var token = await getUserInfoSharedPref("token");
    dio.options.headers["Authorization"] = "Bearer " + token;
    return  await dio.deleteUri(url).then((value){
      print(value.data);

      return response;

    });
  }

  static Future<http.Response> deleteTaskList(idList) async {
    var url;
    var response;
    var dio = DioUtil.getInstance();

    url = Uri.parse('${URLS.BASE_URL}/taskslists/$idList');

    var token = await getUserInfoSharedPref("token");
    dio.options.headers["Authorization"] = "Bearer " + token;
    return  await dio.deleteUri(url).then((value){
      print(value.data);

      return response;

    });
  }

  static getUserTaskLists()async{
    var dio = DioUtil.getInstance();
       final tasksLists = <TaskList>[];

    const String apiUrl = (URLS.BASE_URL + "/taskslists/my");
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
