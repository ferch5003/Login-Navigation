import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_navigation/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends ChangeNotifier {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isLogged = false;
  User _user;

  User get user => _user;
  bool get isLogged => _isLogged;
  TextEditingController get email => _email;
  TextEditingController get password => _password;
  TextEditingController get confirmPassword => _confirmPassword;

  void clean() {
    email.clear();
    password.clear();
    confirmPassword.clear();
    notifyListeners();
  }

  authenticate() async {
    SharedPreferences prefs = await _prefs;
    bool persistedLogIn = prefs.getBool('isLogged') ?? false;

    if (persistedLogIn) {
      final String email = prefs.getString('email');
      final String password = prefs.getString('password');

      _user = User(email, password);

      _isLogged = true;

      clean();
    }
  }

  sigIn() async {
    SharedPreferences prefs = await _prefs;
    Map<String, dynamic> accounts =
        await jsonDecode(prefs.getString('accounts') ?? '{}');

    if (accounts.containsKey(email.text) &&
        accounts[email.text] == password.text) {
      await prefs.setString('email', email.text);
      await prefs.setString('password', email.text);
      await prefs.setBool('isLogged', true);

      _user = User(email.text, password.text);

      _isLogged = true;

      clean();
    }
  }

  logOut() async {
    SharedPreferences prefs = await _prefs;

    _isLogged = false;
    await prefs.setString('email', '');
    await prefs.setString('password', '');
    await prefs.setBool('isLogged', false);

    clean();
  }

  signUp() async {
    SharedPreferences prefs = await _prefs;
    var accounts = await jsonDecode(prefs.getString('accounts') ?? '{}');

    if (!accounts.containsKey(email.text)) {
      if (password.text == confirmPassword.text) {
        accounts[email.text] = password.text;
        await prefs.setString('accounts', jsonEncode(accounts));
        await prefs.setString('email', email.text);
        await prefs.setString('password', email.text);
        await prefs.setBool('isLogged', true);

        _user = User(email.text, password.text);

        _isLogged = true;

        clean();
      }
    }
  }
}
