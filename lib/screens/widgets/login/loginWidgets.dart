import 'package:flutter/material.dart';
import 'package:login_navigation/screens/widgets/fieldWidgets.dart';
import 'package:login_navigation/widgets/roundedBox.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:login_navigation/providers/blocs/UserBloc.dart';
import 'package:provider/provider.dart';

class LoginWidgets extends FieldWidgets {
  final GlobalKey<FormState> formKey;
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  LoginWidgets(this.formKey, context) : super(context);

  void clearAll(TextEditingController emailController,
      TextEditingController passwordController) {
    emailController.clear();
    passwordController.clear();
  }

  AlertDialog customAlertDialog(String title, String message) {
    return AlertDialog(
      title: Text("$title"),
      content: Text("$message"),
      actions: [
        FlatButton(
          child: Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }

  Widget checkRememberMe() {
    return Consumer<UserBloc>(
      builder: (context, userBloc, child) {
        return CheckboxListTile(
            title: Text('Remember me'),
            controlAffinity: ListTileControlAffinity.leading,
            value: userBloc.rememberMe,
            onChanged: (value) {
              userBloc.toggleRememberMe(value);
            });
      },
    );
  }

  Widget logInButton(
      {TextEditingController email, TextEditingController password}) {
    return RoundedLoadingButton(
      controller: _btnController,
      color: Theme.of(context).primaryColor,
      child: Center(
          child: Text(
        'LOG IN',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      )),
      onPressed: () async {
        if (formKey.currentState.validate()) {
          await Provider.of<UserBloc>(context, listen: false)
              .logIn(email: email.text, password: password.text)
              .then((user) {
            clearAll(email, password);
            _btnController.success();
            Provider.of<UserBloc>(context, listen: false).setLoggedIn(user);
          }).catchError((error) {
            print(error);
            _btnController.reset();
            showDialog(
                context: context,
                builder: (context) {
                  return customAlertDialog('ERROR', error);
                });
          }).timeout(Duration(seconds: 10), onTimeout: () {
            _btnController.reset();
            showDialog(
                context: context,
                builder: (context) {
                  return customAlertDialog('ERROR',
                      'The service is not accesible now (time > 10 seconds), try again');
                });
          });
          _btnController.reset();
        } else {
          _btnController.reset();
        }
      },
    );
  }

  Widget signUpRedirect(TextEditingController emailController,
      TextEditingController passwordController) {
    return GestureDetector(
      child: RoundedBox(
        child: Center(
            child: Text(
          'SIGN UP',
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline),
        )),
      ),
      onTap: () {
        formKey.currentState.reset();
        Navigator.pushNamed(context, '/signup').then((onValue) {
          clearAll(emailController, passwordController);
        });
      },
    );
  }
}
