import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:login_navigation/providers/blocs/UserBloc.dart';
import 'package:login_navigation/screens/login.dart';
import 'package:login_navigation/models/course.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:login_navigation/screens/widgets/home/courseCard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<UnicornButton> _childButtons = List<UnicornButton>();

  @override
  void initState() {
    _childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Create course",
        currentButton: FloatingActionButton(
          heroTag: "add",
          backgroundColor: Color(0xFFffbb00),
          mini: true,
          child: Icon(Icons.add),
          onPressed: () {
            Provider.of<UserBloc>(context, listen: false).createCourse();
          },
        )));

    _childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Restart DB",
        currentButton: FloatingActionButton(
          heroTag: "restart",
          backgroundColor: Color(0xFFffbb00),
          mini: true,
          child: Icon(Icons.replay),
          onPressed: () {
            Provider.of<UserBloc>(context, listen: false).restartDB();
          },
        )));

    _childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Log Out",
        currentButton: FloatingActionButton(
          heroTag: "logout",
          backgroundColor: Color(0xFFffbb00),
          mini: true,
          child: Icon(Icons.power_settings_new),
          onPressed: () {
            Provider.of<UserBloc>(context, listen: false).logOut();
          },
        )));

    super.initState();
  }

  @override
  void dispose() {
    Provider.of<UserBloc>(context, listen: false).verifyPersistence();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserBloc>(builder: (context, userBloc, child) {
      if (!userBloc.isLogged) {
        return AnimatedSwitcher(
            duration: Duration(milliseconds: 250),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.25),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
            child: Login());
      } else {
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 250),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.25),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          child: Scaffold(
              body: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: Center(
                          child: Text(
                        'Courses',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30.0),
                      )),
                    ),
                    FutureBuilder<List<Course>>(
                        future: userBloc.getCourses(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return CircularProgressIndicator();
                            default:
                              if (snapshot.hasData) {
                                return Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        Course course = snapshot.data[index];
                                        return CourseCard(
                                          course: course,
                                        );
                                      }),
                                );
                              } else {
                                return Text('ERROR: ${snapshot.error}');
                              }
                          }
                        }),
                  ],
                ),
              ),
              floatingActionButton: UnicornDialer(
                  parentButtonBackground: Colors.white,
                  orientation: UnicornOrientation.VERTICAL,
                  parentButton: Icon(Icons.menu),
                  childButtons: _childButtons)),
        );
      }
    });
  }
}
