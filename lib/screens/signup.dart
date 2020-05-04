import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:login_navigation/providers/blocs/UserBloc.dart';
import 'package:login_navigation/screens/login.dart';
import 'package:login_navigation/screens/widgets/forms.dart';
import 'package:login_navigation/widgets/screen_gradient.dart';
import 'package:login_navigation/widgets/custom_card.dart';

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
  void initState() {
    super.initState();

    Provider.of<UserBloc>(context, listen: false).authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserBloc>(
      builder: (context, userBloc, child) {
        Size phone = MediaQuery.of(context).size;

        if (userBloc.isLogged) {
          return Login();
        } else {
          final Forms _form = Forms(_formKey, context);

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
                        height: phone.height * 0.80,
                        width: phone.width * 0.80,
                        child: Form(
                          key: _formKey,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                _form.emailTextField(_emailController),
                                SizedBox(
                                  height: 20.0,
                                ),
                                _form.passTextField(_passwordController),
                                SizedBox(
                                  height: 20.0,
                                ),
                                _form.nameTextField(_nameController),
                                SizedBox(
                                  height: 20.0,
                                ),
                                _form.usernameTextField(_usernameController),
                                SizedBox(height: 30.0),
                                _form.signUpButton(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    name: _nameController.text,
                                    username: _usernameController.text),
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
      },
    );
  }
}
