class UserModel {
  String? accessToken;
  String? avatarUrl;
  int? birthday;
  int? gender;
  int? gmtCreate;
  int? gmtLastLogin;
  int? gmtUpdate;
  int? id;
  String? lastLoginIp;
  int? level;
  int? loginType;
  String? nickName;
  String? openId;
  String? phone;
  int? status;

  UserModel(
      {this.accessToken,
      this.avatarUrl,
      this.birthday,
      this.gender,
      this.gmtCreate,
      this.gmtLastLogin,
      this.gmtUpdate,
      this.id,
      this.lastLoginIp,
      this.level,
      this.loginType,
      this.nickName,
      this.openId,
      this.phone,
      this.status});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        accessToken: json["accessToken"],
        avatarUrl: json["avatarUrl"],
        birthday: json["birthday"],
        gender: json["gender"],
        gmtCreate: json["gmtCreate"],
        gmtLastLogin: json["gmtLastLogin"],
        gmtUpdate: json["gmtUpdate"],
        id: json["id"],
        lastLoginIp: json["lastLoginIp"],
        level: json["level"],
        loginType: json["loginType"],
        nickName: json["nickName"],
        openId: json["openId"],
        phone: json["phone"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "avatarUrl": avatarUrl,
        "birthday": birthday,
        "gender": gender,
        "gmtCreate": gmtCreate,
        "gmtLastLogin": gmtLastLogin,
        "gmtUpdate": gmtUpdate,
        "id": id,
        "lastLoginIp": lastLoginIp,
        "level": level,
        "loginType": loginType,
        "nickName": nickName,
        "openId": openId,
        "phone": phone,
        "status": status,
      };
}
