import 'package:flutter/material.dart';
import 'package:login_navigation/widgets/rounded_box.dart';
import 'package:login_navigation/widgets/custom_input.dart';
import 'package:login_navigation/providers/UserBloc.dart';
import 'package:provider/provider.dart';

class Forms {
  final GlobalKey<FormState> formKey;
  final BuildContext context;
  final UserBloc userBloc;

  Forms(this.formKey, this.context, this.userBloc);

  Widget emailTextField() {
    return RoundedBox(
      color: Color(0xFFf2f0f7),
      child: CustomInput(
        validator: (email) {
          Pattern pattern = r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
          RegExp regex = RegExp(pattern);
          if (email.isEmpty) return 'The field is empty';
          if (!regex.hasMatch(email)) return 'Invalid email address';
          return null;
        },
        labelText: 'Email',
        keyBoardType: TextInputType.emailAddress,
        textEditingController: userBloc.email,
        prefixIcon: Icon(Icons.account_circle),
        obscureText: false,
      ),
    );
  }

  Widget passTextField() {
    return RoundedBox(
      color: Color(0xFFf2f0f7),
      child: CustomInput(
        validator: (password) {
          Pattern pattern = r'^(\w|[^ ]){6,}$';
          RegExp regex = RegExp(pattern);
          if (password.isEmpty) return 'The field is empty';
          if (!regex.hasMatch(password)) return 'Invalid password';
          return null;
        },
        labelText: 'Password',
        textEditingController: userBloc.password,
        prefixIcon: Icon(Icons.lock),
        suffixIcon: Icon(Icons.remove_red_eye),
        obscureText: true,
      ),
    );
  }

  Widget confirmTextField() {
    return RoundedBox(
      color: Color(0xFFf2f0f7),
      child: CustomInput(
        validator: (password) {
          Pattern pattern = r'^(\w|[^ ]){6,}$';
          RegExp regex = RegExp(pattern);
          if (password.isEmpty) return 'The field is empty';
          if (!regex.hasMatch(password)) return 'Invalid password';
          return null;
        },
        labelText: 'Confirm password',
        textEditingController: userBloc.confirmPassword,
        prefixIcon: Icon(Icons.lock),
        suffixIcon: Icon(Icons.remove_red_eye),
        obscureText: true,
      ),
    );
  }

  Widget logInButton() {
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
            await userBloc.sigIn();

            if (!userBloc.isLogged) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Invalid user or password'),
              ));
            }
          }
        },
      ),
    );
  }

  Widget signUpRedirect() {
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
        Provider.of<UserBloc>(context, listen: false).clean();
        Navigator.pushNamed(context, '/signup');
      },
    );
  }

  Widget signUpButton() {
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
            await Provider.of<UserBloc>(context, listen: false).signUp();

            bool register =
                Provider.of<UserBloc>(context, listen: false).isLogged;

            if (register) {
              Navigator.of(context).pop();
            } else {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('User is registered')));
            }
          }
        },
      ),
    );
  }
}
