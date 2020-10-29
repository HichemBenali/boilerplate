import 'package:crm_app/config/app.dart';
import 'package:crm_app/core/logger.dart';
import 'package:crm_app/services/auth.dart';
import 'package:crm_app/core/storage.dart';
import 'package:dio/dio.dart';

class NetworkDriver {
  static final NetworkDriver _singleton = NetworkDriver._internal();
  Dio _dio = Dio();

  NetworkDriver._internal();
  factory NetworkDriver() {
    return _singleton;
  }

  Future<Dio> getDriver() async {
    try {
      var token;

      token = await StorageDriver().read("USER_TOKEN");

      if (token == null || token == "") {
        token = "Empty";
      }

      _dio.interceptors.clear();
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        // Headers
        options.headers["Authorization"] = "Bearer $token";
        options.headers['content-Type'] = 'application/json';
        options.headers['Accept'] = 'application/json';
        return options;
      }, onResponse: (Response response) {
        return response; // continue
      }, onError: (DioError error) async {
        // Do something with response error
        if (error.response?.statusCode == 403 ||
            error.response?.statusCode == 401) {
          AuthService().logout();
        } else {
          Log.error(
              "[NetworkError] url: ${error.request.path}; response: ${error.response.data}; data: ${error.request.data};",
              error,
              StackTrace.current);
          return error;
        }
      }));
      _dio.options.baseUrl = "$SERVER/api";
      return _dio;
    } catch (err) {
      Log.error("[NetworkError] idk ? $err", err, StackTrace.current);
    }

    return _dio;
  }

  Future<Dio> getDownloader() async {
    try {
      var token;

      token = await StorageDriver().read("USER_TOKEN");

      if (token == null || token == "") {
        token = "Empty";
      }

      _dio.interceptors.clear();
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        // Headers
        options.headers["Authorization"] = "Bearer $token";
        options.headers['content-Type'] = 'application/json';
        options.headers['Accept'] = 'application/json';
        return options;
      }, onResponse: (Response response) {
        return response; // continue
      }, onError: (DioError error) async {
        // Do something with response error
        if (error.response?.statusCode == 403 ||
            error.response?.statusCode == 401) {
          AuthService().logout();
        } else {
          Log.error(
              "[NetworkError] url: ${error.request.path}; response: ${error.response.data}; data: ${error.request.data};",
              error,
              StackTrace.current);
          return error;
        }
      }));
      _dio.options.baseUrl = "$SERVER";
      return _dio;
    } catch (err) {
      Log.error("[NetworkError] idk ? $err", err, StackTrace.current);
    }

    return _dio;
  }
}
