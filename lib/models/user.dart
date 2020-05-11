import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;
  final String username;
  final String token;

  @JsonKey(name: 'type')
  final String tokenType;

  @JsonKey(includeIfNull: false)
  final String error;

  User({this.name, this.username, this.token, this.tokenType, this.error});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
