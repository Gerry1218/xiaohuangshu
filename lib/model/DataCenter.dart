import 'package:xhs/pages/home/Model/UserModel.dart';

class DataCenter {
  DataCenter._();

  static final DataCenter _instance = DataCenter._();

  // 加载上次登录用户信息
  loadUserInfo() {}

  UserModel? currentUserModel;

  factory DataCenter() => _instance;

  //  如果登录过则更新model，未登录则存储
  updateUserModel(model) {
    if (userIsExists(model)) {
      // 更新
    }

    currentUserModel = model;
  }

  bool userIsExists(UserModel model) {
    return true;
  }
}
