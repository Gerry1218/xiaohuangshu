import 'dart:convert';

BlogModel blogModelFromJson(String str) => BlogModel.fromJson(json.decode(str));

String blogModelToJson(BlogModel data) => json.encode(data.toJson());

class BlogModel {
  int? anonymity;
  String? avatarUrl;
  int blogType = 0;
  int commentCount = 0;
  int communityId = 0;
  String? content;
  String? coverUrl;
  int? gmtCreate;
  int? groupId;
  int? id;
  List<String>? imgUrls;
  int? likeCount;
  int? type;
  int? userId;
  String? userName;
  String? videoUrl;
  int? viewCount;

  BlogModel({
    required this.anonymity,
    required this.avatarUrl,
    required this.blogType,
    required this.commentCount,
    required this.communityId,
    required this.content,
    required this.coverUrl,
    required this.gmtCreate,
    required this.groupId,
    required this.id,
    required this.imgUrls,
    required this.likeCount,
    required this.type,
    required this.userId,
    required this.userName,
    required this.videoUrl,
    required this.viewCount,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
        anonymity: json["anonymity"],
        avatarUrl: json["avatarUrl"],
        blogType: json["blogType"],
        commentCount: json["commentCount"],
        communityId: json["communityId"],
        content: json["content"],
        coverUrl: json["coverUrl"],
        gmtCreate: json["gmtCreate"],
        groupId: json["groupId"],
        id: json["id"],
        imgUrls: json["imgUrls"] == null ? [] : List<String>.from(jsonDecode(json["imgUrls"]!)),
        likeCount: json["likeCount"],
        type: json["type"],
        userId: json["userId"],
        userName: json["userName"],
        videoUrl: json["videoUrl"],
        viewCount: json["viewCount"],
      );

  Map<String, dynamic> toJson() => {
        "anonymity": anonymity,
        "avatarUrl": avatarUrl,
        "blogType": blogType,
        "commentCount": commentCount,
        "communityId": communityId,
        "content": content,
        "coverUrl": coverUrl,
        "gmtCreate": gmtCreate,
        "groupId": groupId,
        "id": id,
        "imgUrls": imgUrls,
        "likeCount": likeCount,
        "type": type,
        "userId": userId,
        "userName": userName,
        "videoUrl": videoUrl,
        "viewCount": viewCount,
      };
}
