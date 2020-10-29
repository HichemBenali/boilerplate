import 'dart:io';
import 'package:crm_app/config/app.dart';
import 'package:crm_app/core/database.dart';
import 'package:crm_app/core/logger.dart';
import 'package:crm_app/core/storage.dart';
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
      res = await Dio().post(SERVER + "/api/login", data: {
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
          throw ("Veuillez verifier vos identifiants.");
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
    await StorageDriver().write("USER_NAME", "");
    await StorageDriver().write("GROUPS_LAST_UPDATED", "");
    await DBProvider.destroy();
    authenticated = false;

    return true;
  }
}
