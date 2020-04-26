import 'package:flutter/cupertino.dart';
import 'package:login_navigation/screens/home.dart';
import 'package:login_navigation/screens/login.dart';
import 'package:login_navigation/models/user.dart';

enum WidgetMarker { Home, Login }

class ViewModel extends ChangeNotifier {
  
  WidgetMarker _state = WidgetMarker.Login;
  String _title = 'Login';
  bool _isLogged = false;

  WidgetMarker get state => _state;
  String get title => _title;
  bool get isLogged => _isLogged;

  void changeView() {
    switch (_state) {
      case WidgetMarker.Home:
        _title = 'Login';
        _changeValue(WidgetMarker.Login);
        break;
      case WidgetMarker.Login:
        _title = 'Home';
        _changeValue(WidgetMarker.Home);
        break;
    }
  }

  Widget getScreen() {
    switch (_state) {
      case WidgetMarker.Home:
        return Home(
          viewModel: this
        );
      case WidgetMarker.Login:
        return Login(
          viewModel: this
        );
      default:
        return Login(
          viewModel: this
        );
    }
  }

  void _changeValue(WidgetMarker value) {
    _state = value;
    notifyListeners();
  }
}
