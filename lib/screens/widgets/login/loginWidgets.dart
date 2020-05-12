import 'package:flutter/material.dart';
import 'package:login_navigation/screens/widgets/fieldWidgets.dart';
import 'package:login_navigation/widgets/roundedBox.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:login_navigation/providers/blocs/UserBloc.dart';
import 'package:provider/provider.dart';

class LoginWidgets extends FieldWidgets {
  final GlobalKey<FormState> formKey;

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
            onChanged: (value) => userBloc.toggleRememberMe(value));
      },
    );
  }

  Widget logInButton(
      {TextEditingController email, TextEditingController password}) {
    return ProgressButton(
      color: Theme.of(context).primaryColor,
      borderRadius: 30.0,
      defaultWidget: Center(
          child: Text(
        'LOG IN',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      )),
      progressWidget: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
      onPressed: () async {
        if (formKey.currentState.validate()) {
          await Provider.of<UserBloc>(context, listen: false)
              .logIn(email: email.text, password: password.text)
              .then((user) {
            clearAll(email, password);
            Provider.of<UserBloc>(context, listen: false).setLoggedIn(user);
          }).catchError((error) {
            showDialog(
                context: context,
                builder: (context) {
                  return customAlertDialog('ERROR', error.toString());
                });
          }).timeout(Duration(seconds: 10), onTimeout: () {
            showDialog(
                context: context,
                builder: (context) {
                  return customAlertDialog('ERROR',
                      'The service is not accesible now (time > 10 seconds), try again');
                });
          });
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
