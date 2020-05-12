import 'dart:math';
import 'package:flutter/material.dart';
import 'package:login_navigation/assets/ProjectColors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:login_navigation/models/course.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  CourseCard({this.course});

  @override
  Widget build(BuildContext context) {
    List<Color> projectColors = ProjectColors().colors;

    Random random = new Random();

    int index = random.nextInt(projectColors.length);

    return Container(
      height: 150.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Card(
        elevation: 8,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    color: projectColors[index],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Professor',
                        style: TextStyle(color: Colors.white, fontSize: 10.0),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 23.0),
                      child: AutoSizeText(
                        '${course.professor}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Course',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 10.0),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: Text(
                              'ID ${course.id}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                      child: AutoSizeText(
                        '${course.name}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            LayoutBuilder(
                              builder: (context, constraint) {
                                return Icon(
                                  Icons.account_circle,
                                  size: 13.0,
                                );
                              },
                            ),
                            Text(
                              'STUDENTS: ${course.students}',
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
