import 'package:flutter/material.dart';
import 'package:login_navigation/widgets/screen_gradient.dart';
import 'package:login_navigation/widgets/custom_card.dart';
import 'package:login_navigation/widgets/rounded_box.dart';
import 'package:login_navigation/widgets/custom_input.dart';
import 'package:login_navigation/providers/view_model.dart';

class SignUp extends StatelessWidget {
  final ViewModel viewModel;

  SignUp({this.viewModel});

  @override
  Widget build(BuildContext context) {
    final _userTextField = Container(
      child: RoundedBox(
        width: 200.0,
        color: Color(0xFFf2f0f7),
        child: CustomInput(
          labelText: 'Username',
          prefixIcon: Icon(Icons.account_circle),
          obscureText: false,
        ),
      ),
    );

    final _passTextField = Container(
      margin: const EdgeInsets.only(top: 20.0),
      width: 200.0,
      child: CustomInput(
        labelText: 'Password',
        prefixIcon: Icon(Icons.lock),
        suffixIcon: Icon(Icons.remove_red_eye),
        obscureText: true,
      ),
    );

    final _confirmTextField = Container(
      margin: const EdgeInsets.only(top: 20.0),
      width: 200.0,
      child: CustomInput(
        labelText: 'Confirm password',
        prefixIcon: Icon(Icons.lock),
        suffixIcon: Icon(Icons.remove_red_eye),
        obscureText: true,
      ),
    );

    final _signUp = Container(
      margin: const EdgeInsets.only(top: 35.0),
      width: 100.0,
      height: 50.0,
      child: MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Theme.of(context).primaryColor,
        child: Center(
            child: Text(
          'SIGN UP',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
        onPressed: () => null,
      ),
    );

    return Scaffold(
      body: ScreenGradient(
        child: Container(
          child: Center(
            child: SingleChildScrollView(
              child: CustomCard(
                width: 250.0,
                height: 400.0,
                child: Form(
                  key: UniqueKey(),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 50.0),
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            _userTextField,
                            _passTextField,
                            _confirmTextField,
                            _signUp,
                          ],
                        ),
                      ),
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
}
