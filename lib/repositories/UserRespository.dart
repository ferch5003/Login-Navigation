import 'package:login_navigation/models/user.dart';
import 'package:login_navigation/providers/http/UserApiProvider.dart';

class UserRepository {
  UserApiProvider _apiProvider = UserApiProvider();

  Future<User> signUp(
          String email, String password, String name, String username) =>
      _apiProvider.signUp(email, password, name, username);

  Future<User> logIn(String email, String password) =>
      _apiProvider.logIn(email, password);

  Future<bool> validToken(String token) => _apiProvider.validToken(token);
}
