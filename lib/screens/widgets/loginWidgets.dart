import 'package:flutter/material.dart';
import 'package:login_navigation/screens/widgets/fieldWidgets.dart';
import 'package:login_navigation/widgets/rounded_box.dart';
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

  Widget logInButton(
      {TextEditingController email, TextEditingController password}) {
    return Builder(
      builder: (context) => RaisedButton(
        splashColor: Theme.of(context).accentColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
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
              Provider.of<UserBloc>(context, listen: false).setLoggedIn(user);
              clearAll(email, password);
              return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog();
                  });
            }).catchError((error) {
              return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog();
                  });
            }).timeout(Duration(seconds: 10), onTimeout: () {
              print("timer");
              return Container();
            });
          }
        },
      ),
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
