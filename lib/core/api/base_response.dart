///
/// BaseResponse<CreatePartyRoomModel> resp = BaseResponse.fromJson(response, CreatePartyRoomModel.fromJson);
///
class BaseResponse<T> {
  int? code;
  String? msg;
  String? time;
  T? data;

  BaseResponse({
    this.code,
    this.msg,
    this.time,
    this.data,
  });

  factory BaseResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return BaseResponse<T>(
      code: json["code"],
      msg: json["msg"],
      time: json["time"],
      data: json["data"] == null ? null : fromJsonT(json["data"]),
    );
  }

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return {
      "code": code,
      "msg": msg,
      "time": time,
      "data": data != null ? toJsonT(data!) : null,
    };
  }
}