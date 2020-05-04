import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login_navigation/models/user.dart';
import 'package:login_navigation/repositories/UserRespository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends ChangeNotifier {
  final UserRepository _repository = UserRepository();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isLogged = false;
  User _user;

  User get user => _user;
  bool get isLogged => _isLogged;

  authenticate() async {
    SharedPreferences prefs = await _prefs;
    bool persistedLogIn = prefs.getBool('isLogged') ?? false;

    if (persistedLogIn) {
      final String name = prefs.getString('name');
      final String token = prefs.getString('token');

      _user = User(name: name, token: token);

      _isLogged = true;

      notifyListeners();
    }
  }

  Future<User> signUp({String email, String password, String name, String username}) async {
    return _user = await _repository.signUp(email, password, name, username);
  }

  Future<User> logIn({String email, String password}) async {
    return _user = await _repository.logIn(email, password);
  }

  setLoggedIn(User user) async {
    SharedPreferences prefs = await _prefs;

    await prefs.setString('name', user.name);
    await prefs.setString('token', user.token);
    await prefs.setBool('isLogged', true);

    _isLogged = true;

    notifyListeners();
  }

  logOut() async {
    SharedPreferences prefs = await _prefs;

    await prefs.setString('user', '');
    await prefs.setString('token', '');
    await prefs.setBool('isLogged', false);

    _isLogged = false;

    notifyListeners();
  }
}
