import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:xhs/core/http/constants.dart';
import 'package:xhs/pages/home/Model/BlogModel.dart';
import 'package:xhs/pages/home/Model/UserModel.dart';

import '../../pages/home/Model/CommentItemModel.dart';
import '../http/http_service.dart';

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
    Response<String> response = await HttpService().post(params: params);
    try {
      List<BlogModel> list = [];
      if (response.statusCode == 200) {
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

  static Future<BlogModel?> blogDetail(int userId, int blogId) async {
    var params = {
      "_gp": "blog",
      "_mt": "blogDetail",
      "userId": userId,
      "blogId": blogId,
    };
    Response<String> response = await HttpService().post(params: params);
    try {
      if (response.statusCode == 200) {
        String dataString = response.data!;
        var res = jsonDecode(dataString);
        var data = res["data"];
        BlogModel model = BlogModel.fromJson(data);
        return model;
      }
      return null;
    } catch (err) {
      debugPrint("HTTP err");
    }
    return null;
  }

  static Future<List<CommentItemModel>> blogCommentList(
      int userId, int blogId, int pageNo) async {
    var params = {
      "_gp": "blog",
      "_mt": "selectCommentList",
      "userId": userId,
      "blogId": blogId,
      "pageNo": pageNo,
      "pageSize": kPageSize
    };
    Response<String> response = await HttpService().post(params: params);
    try {
      if (response.statusCode == 200) {
        String dataString = response.data!;
        var res = jsonDecode(dataString);
        var data = res["data"];
        List<CommentItemModel> list = [];
        data.forEach((item) {
          list.add(CommentItemModel.fromJson(item));
        });
        return list;
      }
    } catch (err) {
      debugPrint(" $err");
    }
    return [];
  }

  static Future<UserModel?> appLogin(String phone, String password) async {
    var params = {
      "_gp": "user",
      "_mt": "appLogin",
      "phone": phone,
      "password": password,
      "loginType": 3
    };
    Response<String> response = await HttpService().post(params: params);
    try {
      if (response.statusCode == 200) {
        String dataString = response.data!;
        var res = jsonDecode(dataString);
        UserModel model = UserModel.fromJson(res['data']);
        return model;
      }
      return null;
    } catch (err) {
      debugPrint("");
    }
    return null;
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
