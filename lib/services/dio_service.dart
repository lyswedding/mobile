import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:lys_wedding/UI/authentification/screens/signup.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:lys_wedding/shared/urls.dart';
import 'package:http/http.dart' as http;

class DioUtil {
  static Dio? _instance;

//method for getting dio instance
  static Dio getInstance() {
    _instance ??= createDioInstance();
    return _instance!;
  }

  static Dio createDioInstance() {
    var dio = Dio();
    // adding interceptor
    dio.interceptors.clear();
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options); //modify your request
    }, onResponse: (response, handler) {
      if (response != null) { //on success it is getting called here
        return handler.next(response);
      } else {
        return null;
      }
    }, onError: (DioError e, handler) async {
      if (e.response != null) {
        if (e.response!.statusCode == 401) { //catch the 401 here

          RequestOptions requestOptions = e.requestOptions;
          await refreshToken();
          var accessToken = await getUserInfoSharedPref('token');
          final opts = new Options(method: requestOptions.method);
          dio.options.headers["Authorization"] = "Bearer " + accessToken;
          print(dio.options.headers);
          //dio.options.headers["set-cookie"]=getUserInfoSharedPref('cookie');
          final response = await dio.request(requestOptions.path,
              options: opts,
              cancelToken: requestOptions.cancelToken,
              onReceiveProgress: requestOptions.onReceiveProgress,
              data: requestOptions.data,
              queryParameters: requestOptions.queryParameters);
          if (response != null) {
            handler.resolve(response);
          } else {
            return null;
          }
        } else {
          handler.next(e);
        }
      }
    }));
    return dio;
  }
 static  Map<String, String> headers = {
    "Content-type": "application/json",
  };

  static refreshToken() async {
    // http.Response response;
    //Repository repository = Repository();
    var dio = Dio();
    final Uri apiUrl = Uri.parse('${URLS.BASE_URL}/refresh_token');
    print(apiUrl);
     var refreshToken = await getUserInfoSharedPref('refresh_token');
     print(refreshToken);
    // final options =  Options(
    //   headers: dio.options.headers["x-refresh-token"]=refreshToken,
    // );
    dio.options.headers!["x-refresh-token"] = refreshToken;
    print(dio.options.headers);

    Response response = await dio.postUri(apiUrl);
   // updateCookie(response);
    if (response.statusCode == 200) {
      print('**************Dio***********');
      print(response.data);
      var refreshTokenResponse = response.data;
      String cookie = response.headers['x-refresh-token'].toString();
      print('**************Dio***********');
      await saveAccessTokenSharedPref(refreshTokenResponse['accessToken'],cookie);
      print(refreshTokenResponse);
    } else {
      print('**************Dio***********');
      deleteToken();
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
      print(response.data); //TODO: logout
    }
  }


  // static void updateCookie(Response response) {
  //   String? rawCookie = response.headers['set-cookie'] as String?;
  //   if (rawCookie != null) {
  //     int index = rawCookie.indexOf(';');
  //     headers['cookie'] =
  //     (index == -1) ? rawCookie : rawCookie.substring(0, index);
  //   }
  // }

  // Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
  //   final options = new Options(
  //     method: requestOptions.method,
  //     headers: requestOptions.headers,
  //   );
  //   return this.api.request<dynamic>(requestOptions.path,
  //       data: requestOptions.data,
  //       queryParameters: requestOptions.queryParameters,
  //       options: options);
  // }

}