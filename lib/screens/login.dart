import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:login_navigation/providers/blocs/UserBloc.dart';
import 'package:login_navigation/screens/home.dart';
import 'package:login_navigation/screens/widgets/forms.dart';
import 'package:login_navigation/widgets/screen_gradient.dart';
import 'package:login_navigation/widgets/custom_card.dart';

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
    super.initState();

    Provider.of<UserBloc>(context, listen: false).authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserBloc>(
      builder: (context, userBloc, child) {
        Size phone = MediaQuery.of(context).size;

        if (userBloc.isLogged) {
          return Home();
        } else {
          final Forms _form = Forms(_formKey, context);

          return Scaffold(
            body: ScreenGradient(
              child: Center(
                child: Stack(children: <Widget>[
                  SingleChildScrollView(
                    child: CustomCard(
                      height: phone.height * 0.60,
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
                                height: 30.0,
                              ),
                              _form.logInButton(
                                  email: _emailController.text,
                                  password: _passwordController.text),
                              SizedBox(height: 15.0),
                              _form.signUpRedirect(
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
          );
        }
      },
    );
  }
}
