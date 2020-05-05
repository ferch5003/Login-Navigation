import 'package:flutter/material.dart';
import 'package:login_navigation/screens/widgets/fieldWidgets.dart';
import 'package:login_navigation/widgets/roundedBox.dart';
import 'package:login_navigation/widgets/customInput.dart';
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
    return Builder(
      builder: (context) => RaisedButton(
        splashColor: Theme.of(context).accentColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Theme.of(context).primaryColor,
        child: Center(
            child: Text(
          'SUBMIT',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
        onPressed: () async {
          if (formKey.currentState.validate()) {
            await Provider.of<UserBloc>(context, listen: false)
                .signUp(
                    email: email.text,
                    password: password.text,
                    name: name.text,
                    username: username.text)
                .then((user) {
              Provider.of<UserBloc>(context, listen: false).setLoggedIn(user);
              clearAll(email, password, name, username);
              Navigator.of(context).pop();
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
              return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog();
                  });
            });
          }
        },
      ),
    );
  }
}
