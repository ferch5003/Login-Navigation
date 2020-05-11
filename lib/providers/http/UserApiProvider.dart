import 'dart:io';
import 'package:login_navigation/models/user.dart';
import 'package:login_navigation/models/course.dart';
import 'package:dio/dio.dart';

class UserApiProvider {
  final String _endpoint = "https://movil-api.herokuapp.com";
  final Dio _dio = Dio();

  Future<User> signUp(
      String email, String password, String name, String username) async {
    try {
      Response response = await _dio.post('$_endpoint/signup', data: {
        "email": email,
        "password": password,
        "name": name,
        "username": username
      });
      return User.fromJson(response.data);
    } on DioError catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }

  Future<User> logIn(String email, String password) async {
    try {
      Response response = await _dio.post(
        '$_endpoint/signin',
        data: {
          "email": email,
          "password": password,
        },
      );
      print(response.data);
      return User.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }

  Future<bool> validToken(String token) async {
    try {
      Response response = await _dio.post('$_endpoint/check/token', data: {
        "token": token,
      });
      Map validation = response.data;
      return validation['valid'];
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }

  Future<List<Course>> getCourses(String username, String token) async {
    try {
      Map<String, dynamic> headers = {HttpHeaders.authorizationHeader: token};
      Response response = await _dio.get('$_endpoint/$username/courses',
          options: Options(headers: headers));
      Iterable iterableCourses = response.data;
      List<Course> coursesList = List<Course>.from(
          iterableCourses.map((model) => Course.fromJson(model)));
      return coursesList;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }

  Future<Course> createCourse(String username, String token) async {
    try {
      Map<String, dynamic> headers = {HttpHeaders.authorizationHeader: token};
      Response response = await _dio.post('$_endpoint/$username/courses',
          options: Options(headers: headers));
      return Course.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }

  Future<bool> restartDB(String username, String token) async {
    try {
      Map<String, dynamic> headers = {HttpHeaders.authorizationHeader: token};
      Response response = await _dio.post('$_endpoint/$username/courses',
          options: Options(headers: headers));
      Map validation = response.data;
      return validation['result'];
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }
}
