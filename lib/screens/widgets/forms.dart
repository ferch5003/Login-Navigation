import 'package:flutter/material.dart';
import 'package:login_navigation/widgets/rounded_box.dart';
import 'package:login_navigation/widgets/custom_input.dart';
import 'package:login_navigation/providers/blocs/UserBloc.dart';
import 'package:provider/provider.dart';

class Forms {
  final GlobalKey<FormState> formKey;
  final BuildContext context;

  Forms(this.formKey, this.context);

  Widget emailTextField(TextEditingController emailController) {
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
        textEditingController: emailController,
        prefixIcon: Icon(Icons.email),
        obscureText: false,
      ),
    );
  }

  Widget passTextField(TextEditingController passwordController) {
    return RoundedBox(
      color: Color(0xFFf2f0f7),
      child: CustomInput(
        validator: (password) {
          Pattern pattern = r'^(\w|[^ ]){1,}$';
          RegExp regex = RegExp(pattern);
          if (password.isEmpty) return 'The field is empty';
          if (!regex.hasMatch(password)) return 'Invalid password';
          return null;
        },
        labelText: 'Password',
        textEditingController: passwordController,
        prefixIcon: Icon(Icons.lock),
        suffixIcon: Icon(Icons.remove_red_eye),
        obscureText: true,
      ),
    );
  }

  Widget nameTextField(TextEditingController nameController) {
    return RoundedBox(
      color: Color(0xFFf2f0f7),
      child: CustomInput(
        validator: (name) {
          Pattern pattern = r'^(\w|[^ ]){1,}$';
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

  Widget logInButton({String email, String password}) {
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
            await Provider.of<UserBloc>(context, listen: false)
                .logIn(email: email, password: password)
                .then((user) {
              Provider.of<UserBloc>(context, listen: false).setLoggedIn(user);
              return Container();
            }).catchError((error) {
              print("error: " + error.toString());
              return Container();
            }).timeout(Duration(seconds: 10), onTimeout: () {
              print("timer");
              return Container();
            });
          }
        },
      ),
    );
  }

  Widget signUpRedirect(TextEditingController emailController,
      TextEditingController passwordController) {
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
        Navigator.pushNamed(context, '/signup').then((onValue) {
          emailController.clear();
          passwordController.clear();
        });
      },
    );
  }

  Widget signUpButton(
      {String email, String password, String name, String username}) {
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
                    email: email,
                    password: password,
                    name: name,
                    username: username)
                .then((user) {
              Provider.of<UserBloc>(context, listen: false).setLoggedIn(user);
              return Container();
            }).catchError((error) {
              print("error: " + error.toString());
              return Container();
            }).timeout(Duration(seconds: 10), onTimeout: () {
              return Container();
            });
          }
        },
      ),
    );
  }
}
