import 'package:flutter/material.dart';
import 'package:login_navigation/providers/view_model.dart';

class Home extends StatelessWidget {
  final ViewModel viewModel;

  Home({this.viewModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Center(
          child: Text('Home'),
        ),
      ),
      onTap: () => viewModel.changeView(),
    );
  }
}
