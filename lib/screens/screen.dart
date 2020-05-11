import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:login_navigation/providers/blocs/UserBloc.dart';
import 'package:login_navigation/screens/login.dart';
import 'package:login_navigation/screens/signup.dart';

class Screen extends StatelessWidget {
  Future<Widget> buildPageAsync(Widget widget) async {
    return Future.microtask(() {
      return widget;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if(!currentFocus.hasPrimaryFocus){
              currentFocus.unfocus();
            }
          },
          child: ChangeNotifierProvider(
            create: (context) => UserBloc(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Login Navigation',
              initialRoute: '/',
              routes: {
                '/': (context) => Login(),
                '/signup': (context) => SignUp()
              },
              theme: ThemeData(
                primaryColor: Color(0xFFf38c02),
                accentColor: Color(0xFFffbb00),
              ),
            ),
          ),
        ));
  }
}
