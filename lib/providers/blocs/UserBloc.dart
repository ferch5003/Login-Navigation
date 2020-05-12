import 'package:flutter/material.dart';
import 'package:login_navigation/models/course.dart';
import 'package:login_navigation/models/user.dart';
import 'package:login_navigation/repositories/UserRespository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends ChangeNotifier {
  final UserRepository _repository = UserRepository();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isLogged = false;
  bool _rememberMe = false;
  User _user = User();
  List<Course> _coursesList = List<Course>();

  User get user => _user;
  List<Course> get coursesList => _coursesList;
  bool get isLogged => _isLogged;
  bool get rememberMe => _rememberMe;

  void toggleRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  // USER LOGIC

  void verifyPersistence() async {
    SharedPreferences prefs = await _prefs;
    bool rememberMe = prefs.getBool('rememberMe') ?? false;

    if (!rememberMe) {
      await prefs.setString('name', '');
      await prefs.setString('username', '');
      await prefs.setString('token', '');
      await prefs.setString('tokenType', '');
    }
  }

  void authenticate() async {
    SharedPreferences prefs = await _prefs;
    bool persistedLogIn = prefs.getBool('isLogged') ?? false;
    String token = prefs.getString('token');
    bool isValid = await _repository.validToken(token);

    if (persistedLogIn && isValid) {
      final String name = prefs.getString('name');
      final String username = prefs.getString('username');
      final String token = prefs.getString('token');
      final String tokenType = prefs.getString('tokenType');

      _user = User(
          name: name, username: username, token: token, tokenType: tokenType);

      _isLogged = true;

      notifyListeners();
    }
  }

  Future<User> signUp(
      {String email, String password, String name, String username}) async {
    try {
      User user = await _repository.signUp(email, password, name, username);
      return _user = user;
    } catch (error) {
      throw error;
    }
  }

  Future<User> logIn({String email, String password}) async {
    try {
      User user = await _repository.logIn(email, password);
      return _user = user;
    } catch (error) {
      throw error;
    }
  }

    setLoggedIn(User user) async {
    SharedPreferences prefs = await _prefs;

    await prefs.setString('name', user.name);
    await prefs.setString('username', user.username);
    await prefs.setString('token', user.token);
    await prefs.setString('tokenType', user.tokenType);

    if (_rememberMe) {
      await prefs.setBool('rememberMe', true);
      await prefs.setBool('isLogged', true);
    }

    _rememberMe = false;
    _isLogged = true;

    notifyListeners();
  }

  logOut() async {
    SharedPreferences prefs = await _prefs;

    await prefs.setString('name', '');
    await prefs.setString('username', '');
    await prefs.setString('token', '');
    await prefs.setString('tokenType', '');
    await prefs.setBool('isLogged', false);
    prefs.setBool('rememberMe', false);

    _isLogged = false;

    notifyListeners();
  }
  
  // COURSES LOGIC

  Future<List<Course>> getCourses() async {
    final String username = user.username;
    final String token = '${user.tokenType} ${user.token}';
    List<Course> _coursesList = await _repository.getCourses(username, token);
    _coursesList.sort((a,b) => a.id.compareTo(b.id));
    return _coursesList;
  }

  createCourse() async {
    final String username = user.username;
    final String token = '${user.tokenType} ${user.token}';
    Course newCourse = await _repository.createCourse(username, token);
    _coursesList.add(newCourse);
    notifyListeners();
  }

  Future<bool> restartDB() async {
    final String username = user.username;
    final String token = '${user.tokenType} ${user.token}';

    bool result = await _repository.restartDB(username, token);

    notifyListeners();

    return result;
  }

}
