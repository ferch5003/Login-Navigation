// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) {
  return Course(
      id: json['id'] as int,
      name: json['name'] as String,
      professor: json['professor'] as String,
      students: json['students'] as int);
}

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'professor': instance.professor,
      'students': instance.students
    };
