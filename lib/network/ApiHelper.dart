import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:sense_battle/network/AppException.dart';
import 'package:sense_battle/network/LogginInterceptor.dart';
import 'package:sense_battle/utils/Print.dart';

enum API_CALL_STATE {NOT_CALLED, CALLED}
class ApiHelper {
  

  final TEST_DOMAIN = "http://192.168.0.5:2394/api";
  final LIVE_DOMAIN = "http://ec2-52-79-141-236.ap-northeast-2.compute.amazonaws.com:2394/api";
  final IS_LIVE = true;

  final int APP_VER = 0;

  final HTTP_TIME_OUT_SEC = 3;

  String getDomain() {
    Print.i('getDomain $IS_LIVE');
    return IS_LIVE? LIVE_DOMAIN: TEST_DOMAIN;
  }

  Client http = InterceptedClient.build(interceptors: [
    LogginInterceptor(),
  ]);

  Future<dynamic> get(String url) async {
    Print.i(" WHAT>>> : $url" );
    var responseJson;
    String token = await getString(SharedPrefKeys.JWT_TOKEN);
    try {
      final response = await http.get(
        getDomain() + url,
        headers: {
          "x-access-token": token
        }
      );
      responseJson = _returnResponse(response);
    } on Exception catch(_) {
      Print.e(_);
      throw FetchDataException(_.toString());
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    var responseJson;
    String token = await getString(SharedPrefKeys.JWT_TOKEN);
    try {
      final response = await http.post(
        getDomain() + url,
        headers: {
          "x-access-token": token,
          "Content-Type": "application/json"
        },
        body: body
      );
      responseJson = _returnResponse(response);
    } catch (e) {
      throw e;
    }
    return responseJson;
  }
  Future<dynamic> patch(String url, dynamic body) async {
    var responseJson;
    String token = await getString(SharedPrefKeys.JWT_TOKEN);
    try {
      final response = await http.patch(
        getDomain() + url,
        headers: {
          "x-access-token": token,
          "Content-Type": "application/json"
        },
        body: body
      );
      responseJson = _returnResponse(response);
    } on Exception  {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
  Future<dynamic> delete(String url) async {
    var responseJson;
    String token = await getString(SharedPrefKeys.JWT_TOKEN);
    try {
      final response = await http.delete(
        getDomain() + url,
        headers: {
          "x-access-token": token
        }
      );
      responseJson = _returnResponse(response);
    } on Exception  {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
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
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}