import 'package:flutter/material.dart';

class RoundedBox extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsets margin;
  final Color color;
  final bool elevation;
  final Widget child;

  RoundedBox(
      {key,
      this.width,
      this.height,
      this.margin,
      this.color,
      this.elevation = false,
      this.child})
      : super(key: key);

  List<BoxShadow> getShadow() {
    return elevation
        ? [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0),
              blurRadius: 6.0,
            )
          ]
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(bottom: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: color,
        boxShadow: getShadow(),
      ),
      child: child,
    );
  }
}
