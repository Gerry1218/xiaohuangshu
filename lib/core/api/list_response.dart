///
/// BaseListResponse familyResponse =
///             BaseListResponse<FamilyMemberModel, Object>.fromJson(resp, (json) => FamilyMemberModel.fromJson(json));
///
class ListResponse<T> {
  int? code;
  String? msg;
  String? time;
  List<T>? data;

  ListResponse({
    this.code,
    this.msg,
    this.time,
    this.data,
  });

  factory ListResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return ListResponse<T>(
      code: json["code"],
      msg: json["msg"],
      time: json["time"],
      data: json["data"] == null ? [] : List<T>.from(json["data"]!.map((x) => fromJsonT(x))),
    );
  }

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return {
      "code": code,
      "msg": msg,
      "time": time,
      "data": data == null ? [] : List<dynamic>.from(data!.map((x) => toJsonT(x))),
    };
  }
}
