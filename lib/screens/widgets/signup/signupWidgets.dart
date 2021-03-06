import 'package:flutter/material.dart';
import 'package:login_navigation/screens/widgets/fieldWidgets.dart';
import 'package:login_navigation/widgets/roundedBox.dart';
import 'package:login_navigation/widgets/customInput.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:login_navigation/providers/blocs/UserBloc.dart';
import 'package:provider/provider.dart';

class SignupWidgets extends FieldWidgets {
  final GlobalKey<FormState> formKey;

  SignupWidgets(this.formKey, context) : super(context);

  void clearAll(
      TextEditingController emailController,
      TextEditingController passwordController,
      TextEditingController nameController,
      TextEditingController usernameController) {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    usernameController.clear();
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

  Widget nameTextField(TextEditingController nameController) {
    return RoundedBox(
      color: Color(0xFFf2f0f7),
      child: CustomInput(
        validator: (name) {
          Pattern pattern = r'^(\w|[^\w]){1,}$';
          RegExp regex = RegExp(pattern);
          if (name.isEmpty) return 'The field is empty';
          if (!regex.hasMatch(name)) return 'Invalid Name';
          return null;
        },
        labelText: 'Name',
        textEditingController: nameController,
        prefixIcon: Icon(Icons.account_circle),
        obscureText: false,
      ),
    );
  }

  Widget usernameTextField(TextEditingController usernameController) {
    return RoundedBox(
      color: Color(0xFFf2f0f7),
      child: CustomInput(
        validator: (name) {
          Pattern pattern = r'^(\w|[^ ]){1,}$';
          RegExp regex = RegExp(pattern);
          if (name.isEmpty) return 'The field is empty';
          if (!regex.hasMatch(name)) return 'Invalid Username';
          return null;
        },
        labelText: 'Username',
        textEditingController: usernameController,
        prefixIcon: Icon(Icons.account_circle),
        obscureText: false,
      ),
    );
  }

  Widget signUpButton(
      {TextEditingController email,
      TextEditingController password,
      TextEditingController name,
      TextEditingController username}) {
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
              .signUp(
                  email: email.text,
                  password: password.text,
                  name: name.text,
                  username: username.text)
              .then((user) {
            clearAll(email, password, name, username);
            Provider.of<UserBloc>(context, listen: false).setLoggedIn(user);
            Navigator.of(context).pop();
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
}
