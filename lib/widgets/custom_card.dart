import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {

  final double width;
  final double height;
  final Widget child;

  CustomCard({key,this.width, this.height, this.child}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      elevation: 4,
      child: Container(child: child, width: width, height: height),
    );
  }
}