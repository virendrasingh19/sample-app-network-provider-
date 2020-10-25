import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

import 'api_base.dart';
import 'api_exceptions.dart';

class HttpClient {
  static final HttpClient _singleton = HttpClient();

  static HttpClient get instance => _singleton;

  Future<dynamic> fetchData(String url, {Map<String, String> params}) async {
    var responseJson;

    var uri = APIBase.baseURL + url + ((params != null) ? this.queryParameters(params) : "");
    print(uri);
    /// Send authorization headers to the backend.
    /// we can use UtilClass.getJwtToken();
    Map<String, String> headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': 'Basic your_api_token_here'
    };
    try {
      final response = await http.get(uri, headers: headers).timeout(Duration(seconds: 30));
      print(response.body.toString());
      responseJson = _returnResponse(response);
    } on TimeoutException catch (e) {
      /// handle timeout
      throw TimeOutException(e.message.toString());
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  /// you can use the method when you want to cache the data
  Future<dynamic> fetchDataAndCache(String url, {Map<String, String> params}) async {
    var responseJson;

    var uri = APIBase.baseURL + url + ((params != null) ? this.queryParameters(params) : "");
    print(uri);
    Map<String, String> headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': 'Basic your_api_token_here'
    };
    try {
      var file = await DefaultCacheManager().getSingleFile(uri, headers: headers);
      if (file != null && await file.exists()) {
        var res = await file.readAsString();
        print(res.toString());
        responseJson = _returnResponse(http.Response(res, 200));
      }
    } on TimeoutException catch (e) {
      /// handle timeout
      throw TimeOutException(e.message.toString());
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  String queryParameters(Map<String, String> params) {
    if (params != null) {
      final jsonString = Uri(queryParameters: params);
      return '?${jsonString.query}';
    }
    return '';
  }

  Future<dynamic> postData(String url, dynamic body) async {
    var responseJson;
    var header = {HttpHeaders.contentTypeHeader: 'application/json'};
    try {
      final response =
      await http.post(APIBase.baseURL + url, body: body, headers: header);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}