import 'package:flutter/material.dart';
import 'package:login_navigation/widgets/roundedBox.dart';
import 'package:login_navigation/widgets/customInput.dart';
import 'package:login_navigation/widgets/customPasswordInput.dart';

class FieldWidgets {
  final BuildContext context;

  FieldWidgets(this.context);

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
      child: CustomPasswordInput(
        validator: (password) {
          Pattern pattern = r'^(\w|[^ ]){4,}$';
          RegExp regex = RegExp(pattern);
          if (password.isEmpty) return 'The field is empty';
          if (!regex.hasMatch(password)) return 'Invalid password';
          return null;
        },
        labelText: 'Password',
        textEditingController: passwordController,
        prefixIcon: Icon(Icons.lock),
      ),
    );
  }
}
