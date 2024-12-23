///
/// BaseListResponse model = BaseListResponse<DailyTask, SignExtModel>.fromJson(
///          response, (json) => DailyTask.fromJson(json),
///           fromJsonK: (json) => SignExtModel.fromJson(json));
///
///
class BaseListResponse<T, K> {
  int? code;
  String? msg;
  String? time;
  ModelData<T, K>? data;

  BaseListResponse({
    this.code,
    this.msg,
    this.time,
    this.data,
  });

  factory BaseListResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT,
          {K Function(Map<String, dynamic>)? fromJsonK}) =>
      BaseListResponse(
        code: json["code"],
        msg: json["msg"],
        time: json["time"],
        data: json["data"] == null ? null : ModelData<T, K>.fromJson(json["data"], fromJsonT, fromJsonK),
      );

  Map<String, dynamic> toJson({Map<String, dynamic> Function(K k)? toJsonK}) => {
        "code": code,
        "msg": msg,
        "time": time,
        "data": data?.toJson(toJsonK),
      };
}

class ModelData<T, K> {
  int? count;
  List<T>? list;
  K? ext;

  ModelData({this.count, this.list, this.ext});

  factory ModelData.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT,
          K Function(Map<String, dynamic>)? fromJsonK) =>
      ModelData(
          count: json["count"],
          list: json["list"] == null ? [] : List<T>.from(json["list"].map((x) => fromJsonT(x))),
          ext: (json["ext"] == null || fromJsonK == null) ? null : fromJsonK(json["ext"]));

  Map<String, dynamic> toJson(Map<String, dynamic> Function(K k)? toJsonK) => {
        "count": count,
        "list": list == null ? [] : List<dynamic>.from(list!.map((x) => (x as dynamic).toJson())),
        "ext": (ext == null || toJsonK == null) ? null : toJsonK(ext as K)
      };
}
