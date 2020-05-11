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
          backgroundColor:  Color(0xFFffbb00),
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
          backgroundColor:  Color(0xFFffbb00),
          mini: true,
          child: Icon(Icons.menu),
          onPressed: () {
            Provider.of<UserBloc>(context, listen: false).restartDB();
          },
        )));

    _childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Log Out",
        currentButton: FloatingActionButton(
          heroTag: "logout",
          backgroundColor:  Color(0xFFffbb00),
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
        return Login();
      } else {
        return Scaffold(
          body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                    child: Text(
                  'Courses',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                )),
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
            backgroundColor: Colors.black,
            parentButtonBackground: Color.fromRGBO(255, 255, 255, 0.6),
            orientation: UnicornOrientation.VERTICAL,
            parentButton: Icon(Icons.add),
            childButtons: _childButtons)
        );
      }
    });
  }
}
