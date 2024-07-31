import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:xhs/constants/environment.dart';
import 'package:xhs/model/DataCenter.dart';

class HttpService {
  static final HttpService _instance = HttpService._internal();
  Dio? dio;

  factory HttpService() {
    return _instance;
  }

  HttpService._internal() {
    dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 5), // 连接超时时间
        receiveTimeout: const Duration(seconds: 3), // 响应超时时间
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
        }));
  }

  Future<Response> get(String url, {Map<String, dynamic>? params}) async {
    return dio!.get(url, queryParameters: params);
  }

  Future<Response<T>> post<T>(
      {String url = Environment.baseUrl, Map<String, dynamic>? params}) async {
    if (DataCenter().currentUserModel != null) {
      var token = DataCenter().currentUserModel!.accessToken;
      dio?.options.headers['access-token'] = token;
    }
    debugPrint("http post header: ${dio?.options.headers}");
    return dio!.post(url, data: params);
  }
}
