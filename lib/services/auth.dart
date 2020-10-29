import 'dart:io';
import '../config/app.dart';
import '../core/database.dart';
import '../core/logger.dart';
import '../core/storage.dart';
import 'package:dio/dio.dart';

class AuthService {
  static final AuthService _singleton = AuthService._internal();
  String username;
  String token;
  bool authenticated = true;

  factory AuthService() {
    return _singleton;
  }

  AuthService._internal();

  Future<bool> isAuthenticated() async {
    token = await StorageDriver().read("USER_TOKEN");
    authenticated = token != null && token != "";
    return authenticated;
  }

  Future<bool> attempt(String username, String password) async {
    var res;
    Log.verbose("[AuthService] attempting login.");
    try {
      res = await Dio().post(SERVER + "/login", data: {
        "email": username,
        "password": password,
      });
      token = res.data['token'];
      StorageDriver().write("USER_TOKEN", token);
      authenticated = true;
      return true;
    } on SocketException {
      Log.debug("[AuthService] no internet access.");
      throw ("No internet access.");
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          throw ("Unauthorized.");
        }
      }
      Log.wtf("[AuthService]", error);
      throw error;
    }
  }

  logout() async {
    Log.verbose("[AuthService] attempting logout.");
    username = "";
    token = "";
    await StorageDriver().write("USER_TOKEN", "");
    await DBProvider.destroy();
    authenticated = false;

    return true;
  }
}
