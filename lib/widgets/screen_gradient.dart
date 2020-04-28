import 'package:flutter/material.dart';

class ScreenGradient extends StatelessWidget {

  final Widget child;

  ScreenGradient({ this.child });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [
            Color(0xFFffbb00),
            Color(0xFFf38c02),
          ],
          begin: const FractionalOffset(1.0, 0.1),
          end: const FractionalOffset(1.0, 0.9),
        ),
      ),
      child: child,
    );
  }
}