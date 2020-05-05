import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onSubmit;
  final String text;

  SubmitButton({this.text, this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      splashColor: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      color: Theme.of(context).primaryColor,
      child: Center(
          child: Text(
        '$text',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      )),
      onPressed: () => onSubmit,
    );
  }
}
