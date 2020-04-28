import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:login_navigation/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login_navigation/widgets/screen_gradient.dart';
import 'package:login_navigation/widgets/custom_card.dart';
import 'package:login_navigation/widgets/rounded_box.dart';
import 'package:login_navigation/widgets/custom_input.dart';
import 'package:login_navigation/providers/UserBloc.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    Provider.of<UserBloc>(context, listen: false).authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserBloc>(
      builder: (context, userBloc, child) {
        if (userBloc.isLogged) {
          return Login();
        } else {
          final _emailTextField = RoundedBox(
            color: Color(0xFFf2f0f7),
            child: CustomInput(
              validator: (email) {
                Pattern pattern =
                    r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
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

          final _passTextField = RoundedBox(
            color: Color(0xFFf2f0f7),
            child: CustomInput(
              validator: (password) {
                Pattern pattern =
                    r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
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

          final _confirmTextField = RoundedBox(
            color: Color(0xFFf2f0f7),
            child: CustomInput(
              validator: (password) {
                Pattern pattern =
                    r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
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

          final _signUpButton = Builder(
            builder: (context) => RaisedButton(
              splashColor: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              color: Theme.of(context).primaryColor,
              child: Center(
                  child: Text(
                'SUBMIT',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Provider.of<UserBloc>(context, listen: false).signUp();

                  bool register =
                      Provider.of<UserBloc>(context, listen: false).isLogged;
                  if (register) {
                    Navigator.of(context).pop();
                  } else {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('User is registered')));
                  }
                }
              },
            ),
          );

          return Scaffold(
            body: ScreenGradient(
              child: SingleChildScrollView(
                child: CustomCard(
                  height: 400,
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.0, vertical: 120.0),
                  child: Form(
                    onWillPop: () async {
                      Provider.of<UserBloc>(context, listen: false).clean();
                      Navigator.of(context).pop();
                      return true;
                    },
                    key: _formKey,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _emailTextField,
                          SizedBox(
                            height: 20.0,
                          ),
                          _passTextField,
                          SizedBox(
                            height: 20.0,
                          ),
                          _confirmTextField,
                          SizedBox(height: 30.0),
                          _signUpButton,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
