import 'package:flutter/material.dart';

class CustomPasswordInput extends StatefulWidget {
  final String labelText;
  final Icon prefixIcon;
  final TextInputType keyBoardType;
  final Function(String) validator;
  final Function(String) onFieldSubmitted;
  final TextInputAction textInputAction;
  final TextEditingController textEditingController;

  CustomPasswordInput(
      {key,
      this.labelText,
      this.prefixIcon,
      this.keyBoardType,
      this.validator,
      this.onFieldSubmitted,
      this.textInputAction,
      this.textEditingController})
      : super(key: key);

  @override
  _CustomPasswordInputState createState() => _CustomPasswordInputState();
}

class _CustomPasswordInputState extends State<CustomPasswordInput> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: IconButton(
          icon: _hidePassword
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
          onPressed: () {
            setState(() {
              _hidePassword = !_hidePassword;
            });
          },
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Color(0xFFf2f0f7))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            gapPadding: 5.0),
        labelText: '${widget.labelText}',
      ),
      controller: widget.textEditingController,
      keyboardType: widget.keyBoardType,
      obscureText: _hidePassword,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}
