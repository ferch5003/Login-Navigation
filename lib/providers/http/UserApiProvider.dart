import 'dart:io';

import 'package:login_navigation/models/user.dart';
import 'package:dio/dio.dart';

class UserApiProvider {
  final String _endpoint = "https://movil-api.herokuapp.com";
  final Dio _dio = Dio();

  Future<User> signUp(
      String email, String password, String name, String username) async {
    try {
      Response response = await _dio.post('$_endpoint/signup',
          data: {
            "email": email,
            "password": password,
            "name": name,
            "username": username
          },
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
          ));
      return User.fromJson(response.data);
    } on DioError catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }

  Future<User> logIn(String email, String password) async {
    try {
      Response response = await _dio.post('$_endpoint/signin',
          data: {
            "email": email,
            "password": password,
          },
          options: Options());
      return User.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }
}
