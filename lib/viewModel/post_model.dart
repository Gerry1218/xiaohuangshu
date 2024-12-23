import 'dart:core';
import 'dart:ffi';

class PostModel {
  String? username;
  String? avatar;
  String? content;
  int? like;
  List<String>? imgUrl;

  PostModel({this.username, this.avatar, this.like, this.content, this.imgUrl});

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
      username: json["username"],
      avatar: json["avatar"],
      like: json["like"],
      content: json["content"],
      imgUrl: json["imgUrl"].cast<String>());

  Map<String, dynamic> toJson() => {
        "username": username,
        "avatar": avatar,
        "like": like,
        "content": content,
        "imgUrl": imgUrl
      };
}
