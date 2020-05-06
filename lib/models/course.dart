import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Course {
  final int id;
  final String name;
  final String professor;
  final int students;
  final bool test;

  Course({this.id, this.name, this.professor, this.students});

}
