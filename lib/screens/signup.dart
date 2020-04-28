import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:login_navigation/providers/UserBloc.dart';
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
          final Forms _form = Forms(_formKey, context, userBloc);

          return WillPopScope(
            onWillPop: () async {
              Provider.of<UserBloc>(context, listen: false).clean();
              return true;
            },
            child: Scaffold(
              body: ScreenGradient(
                child: SingleChildScrollView(
                  child: CustomCard(
                    height: 400,
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 120.0),
                    child: Form(
                      key: _formKey,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _form.emailTextField(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _form.passTextField(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _form.confirmTextField(),
                            SizedBox(height: 30.0),
                            _form.signUpButton(),
                          ],
                        ),
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
