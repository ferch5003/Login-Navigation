import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:login_navigation/screens/login.dart';
import 'package:login_navigation/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login_navigation/providers/blocs/UserBloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    
    Provider.of<UserBloc>(context, listen: false).authenticate();

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserBloc>(builder: (context, userBloc, child) {
      if (!userBloc.isLogged) {
        return Login();
      } else {
        return Scaffold(
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Consumer<UserBloc>(
                    builder: (context, userBloc, child) {
                      User user = userBloc.user;
                      return Text(
                        'Welcome back, ${user.name}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      );
                    },
                  ),
                ),
                Container(
                  child: MaterialButton(
                    child: Center(
                      child: Text('LOG OUT'),
                    ),
                    onPressed: () {
                      userBloc.logOut();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}
