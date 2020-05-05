import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String labelText;
  final Icon prefixIcon;
  final Icon suffixIcon;
  final bool obscureText;
  final TextInputType keyBoardType;
  final Function(String) validator;
  final Function(String) onFieldSubmitted;
  final TextInputAction textInputAction;
  final TextEditingController textEditingController;

  CustomInput(
      {key,
      this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText,
      this.keyBoardType,
      this.validator,
      this.onFieldSubmitted,
      this.textInputAction,
      this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Color(0xFFf2f0f7))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            gapPadding: 5.0),
        labelText: '$labelText',
      ),
      controller: textEditingController,
      keyboardType: keyBoardType,
      obscureText: obscureText,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
