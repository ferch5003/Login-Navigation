import 'package:flutter/material.dart';
import 'package:login_navigation/screens/widgets/signupWidgets.dart';
import 'package:login_navigation/widgets/screenGradient.dart';
import 'package:login_navigation/widgets/customCard.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  void clearAll() {
    _emailController.clear();
    _passwordController.clear();
    _nameController.clear();
    _usernameController.clear();
  }

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _usernameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SignupWidgets _signupWidgets = SignupWidgets(_formKey, context);
    Size phoneSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        clearAll();
        return true;
      },
      child: Scaffold(
        body: ScreenGradient(
          child: Center(
            child: Stack(children: <Widget>[
              SingleChildScrollView(
                child: CustomCard(
                  height: phoneSize.height * 0.80,
                  width: phoneSize.width * 0.80,
                  child: Form(
                    key: _formKey,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _signupWidgets.emailTextField(_emailController),
                          SizedBox(
                            height: 20.0,
                          ),
                          _signupWidgets.passTextField(_passwordController),
                          SizedBox(
                            height: 20.0,
                          ),
                          _signupWidgets.nameTextField(_nameController),
                          SizedBox(
                            height: 20.0,
                          ),
                          _signupWidgets.usernameTextField(_usernameController),
                          SizedBox(height: 30.0),
                          _signupWidgets.signUpButton(
                              email: _emailController,
                              password: _passwordController,
                              name: _nameController,
                              username: _usernameController),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
