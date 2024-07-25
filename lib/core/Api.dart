import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:xhs/core/HTTP/Constants.dart';
import 'package:xhs/pages/home/Model/BlogModel.dart';

import 'HTTP/HttpService.dart';

class Api {
  static Future<List<BlogModel>> selectBlogList(
      int pageNo, int communityId) async {
    var params = {
      "_gp": "blog",
      "_mt": "selectBlogList",
      "communityId": communityId,
      "pageNo": pageNo,
      "pageSize": kPageSize
    };
    Response<String> response =
        await HttpService().post(kBaseUrl, params: params);
    try {
      List<BlogModel> list = [];
      if (response?.statusCode == 200) {
        String dataString = response.data!;
        var res = jsonDecode(dataString);
        var data = res["data"];
        data.forEach((item) {
          list.add(BlogModel.fromJson(item));
        });
      }
      return list;
    } catch (err) {
      debugPrint("HTTP err");
    }
    return [];
  }
}

class User {
  final int id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
