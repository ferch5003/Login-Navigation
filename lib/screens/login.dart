import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:login_navigation/providers/blocs/UserBloc.dart';
import 'package:login_navigation/screens/widgets/login/loginWidgets.dart';
import 'package:login_navigation/widgets/screenGradient.dart';
import 'package:login_navigation/widgets/customCard.dart';
import 'package:login_navigation/screens/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    Provider.of<UserBloc>(context, listen: false).authenticate();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserBloc>(
      builder: (context, userBloc, child) {
        if (userBloc.isLogged) {
          return AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.25),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
              child: Home());
        } else {
          final LoginWidgets _loginWidgets = LoginWidgets(_formKey, context);
          Size phoneSize = MediaQuery.of(context).size;

          return AnimatedSwitcher(
            duration: Duration(milliseconds: 250),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.25),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
            child: Scaffold(
              body: ScreenGradient(
                child: Center(
                  child: Stack(children: <Widget>[
                    SingleChildScrollView(
                      child: CustomCard(
                        height: phoneSize.height * 0.65,
                        width: phoneSize.width * 0.80,
                        child: Form(
                          key: _formKey,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                _loginWidgets.emailTextField(_emailController),
                                SizedBox(
                                  height: 20.0,
                                ),
                                _loginWidgets
                                    .passTextField(_passwordController),
                                SizedBox(
                                  height: 10.0,
                                ),
                                _loginWidgets.checkRememberMe(),
                                SizedBox(
                                  height: 10.0,
                                ),
                                _loginWidgets.logInButton(
                                    email: _emailController,
                                    password: _passwordController),
                                SizedBox(height: 15.0),
                                _loginWidgets.signUpRedirect(
                                    _emailController, _passwordController),
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
