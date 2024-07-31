import 'dart:convert';

List<CommentItemModel> commentItemModelFromJson(String str) =>
    List<CommentItemModel>.from(
        json.decode(str).map((x) => CommentItemModel.fromJson(x)));

String commentItemModelToJson(List<CommentItemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommentItemModel {
  String avatarUrl;
  String? commentContent;
  int gmtCreate;
  bool hasLike;
  int id;
  int likeCount;
  List<CommentItemModel>? replyList;
  int status;
  int userId;
  String userName;
  String? replyContent;

  CommentItemModel({
    required this.avatarUrl,
    this.commentContent,
    required this.gmtCreate,
    required this.hasLike,
    required this.id,
    required this.likeCount,
    this.replyList,
    required this.status,
    required this.userId,
    required this.userName,
    this.replyContent,
  });

  factory CommentItemModel.fromJson(Map<String, dynamic> json) =>
      CommentItemModel(
        avatarUrl: json["avatarUrl"],
        commentContent: json["commentContent"],
        gmtCreate: json["gmtCreate"],
        hasLike: json["hasLike"],
        id: json["id"],
        likeCount: json["likeCount"],
        replyList: json["replyList"] == null
            ? []
            : List<CommentItemModel>.from(
                json["replyList"]!.map((x) => CommentItemModel.fromJson(x))),
        status: json["status"],
        userId: json["userId"],
        userName: json["userName"],
        replyContent: json["replyContent"],
      );

  Map<String, dynamic> toJson() => {
        "avatarUrl": avatarUrl,
        "commentContent": commentContent,
        "gmtCreate": gmtCreate,
        "hasLike": hasLike,
        "id": id,
        "likeCount": likeCount,
        "replyList": replyList == null
            ? []
            : List<dynamic>.from(replyList!.map((x) => x.toJson())),
        "status": status,
        "userId": userId,
        "userName": userName,
        "replyContent": replyContent,
      };
}
