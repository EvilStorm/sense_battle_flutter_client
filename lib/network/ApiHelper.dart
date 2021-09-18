import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:sense_battle/models/model_response.dart';
import 'package:sense_battle/network/AppException.dart';
import 'package:sense_battle/network/LogginInterceptor.dart';
import 'package:sense_battle/utils/Print.dart';

enum API_CALL_STATE { NOT_CALLED, CALLED }

class ApiHelper {
  final pathPrefix = '/api';
  final TEST_DOMAIN = "192.168.0.6:2394";
  final LIVE_DOMAIN = "ec2-52-79-141-236.ap-northeast-2.compute.amazonaws.com:2394";
  final IS_LIVE = false;

  final int APP_VER = 0;

  final HTTP_TIME_OUT_SEC = 3;

  static final ApiHelper instance = ApiHelper.init();
  factory ApiHelper() {
    return instance;
  }

  ApiHelper.init() {}

  Map<String, String> header = {};
  void addHeader(key, value) {
    header[key] = value;
  }

  String getDomain() {
    Print.i('getDomain $IS_LIVE');
    return IS_LIVE ? LIVE_DOMAIN : TEST_DOMAIN;
  }

  Client http = InterceptedClient.build(interceptors: [
    LogginInterceptor(),
  ]);

  Future<ResponseModel> get(String path, {Map<String, dynamic> queryParams = const {}}) async {
    try {
      final uri = Uri.http(getDomain(), "$pathPrefix/$path", queryParams);

      final response = await http.get(uri, headers: header);

      return ResponseModel.fromMap(_returnResponse(response));
    } on Exception catch (_) {
      Print.e(_);
      throw FetchDataException(_.toString());
    }
  }

  Future<ResponseModel> post(String path, {dynamic queryParams, dynamic body}) async {
    try {
      final uri = Uri.http(getDomain(), "$pathPrefix/$path", queryParams);
      final response = await http.post(uri, headers: header, body: body);
      return ResponseModel.fromMap(_returnResponse(response));
    } catch (e) {
      throw e;
    }
  }

  Future<ResponseModel> patch(String path, {dynamic queryParams = const {}, dynamic body = const {}}) async {
    try {
      final uri = Uri.http(getDomain(), "$pathPrefix/$path", queryParams);
      final response = await http.put(uri, headers: header, body: body);
      return ResponseModel.fromMap(_returnResponse(response));
    } on Exception {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<ResponseModel> delete(String path) async {
    try {
      final uri = Uri.http(getDomain(), "$pathPrefix/$path");
      final response = await http.delete(uri, headers: header);
      return ResponseModel.fromMap(_returnResponse(response));
    } on Exception {
      throw FetchDataException('No Internet connection');
    }
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
        throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
