import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:xhs/core/api/api.dart';
import 'package:xhs/pages/home/Model/UserModel.dart';

class DatabaseUtils {
  static final DatabaseUtils _instance = DatabaseUtils._();

  factory DatabaseUtils() => _instance;

  static Database? _database;

  DatabaseUtils._();

  UserModel? currentUserModel;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database?> _initDatabase() async {
    var path = await getDatabasesPath();
    final dbPath = join(path, "xhs.db");
    debugPrint("dbPath: $dbPath}");
    return openDatabase(dbPath, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE xhs_user (
        id INTEGER PRIMARY KEY,
        nickName TEXT,
        avatarUrl TEXT,
        level INTEGER,
        loginType INTEGER,
        openId TEXT,
        phone TEXT,
        status INTEGER,
        gmtCreate INTEGER,
        gmtUpdate INTEGER
      )
    ''');
  }

  Future<int> insertUser(Map<String, dynamic> data) async {
    Database db = await database;
    return await db.insert('xhs_user', data);
  }

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    Database db = await database;
    return await db.query('xhs_user');
  }

  Future<List<UserModel>> users(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query('xhs_user');

    return List.generate(maps.length, (i) {
      return UserModel.fromJson(maps[i]);
    });
  }

  Future<int> updateUser(Database db, UserModel user) async {
    var json = jsonToUserTable(user);
    return await db.update(
      'xhs_user',
      json,
      where: "id = ?",
      whereArgs: [user.id],
    );
  }

  Future<List<Map<String, dynamic>>> queryUser(UserModel user) async {
    Database db = await database;
    List<Map<String, dynamic>> list = await db.query('xhs_user',
        columns: ['id'], where: 'id = ?', whereArgs: [user.id]);
    return list;
  }

  void updateOrInsertUser(UserModel user) async {
    currentUserModel = user;

    List<Map<String, dynamic>> list = await queryUser(user);
    Database db = await database;
    if (list.isNotEmpty) {
      int res = await updateUser(db, user);
      if (res == 0) {
        debugPrint("update fail");
      }
    } else {
      // 移除表中不存在的字段
      var json = jsonToUserTable(user);

      int res = await insertUser(json);
      if (res == 0) {
        debugPrint("insert fail");
      }
    }
  }

  jsonToUserTable(UserModel user) {
    var json = user.toJson();
    json.remove('accessToken');
    json.remove('birthday');
    json.remove('gender');
    json.remove('gmtLastLogin');
    json.remove('gmtUpdate');
    json.remove('lastLoginIp');
    return json;
  }
}
