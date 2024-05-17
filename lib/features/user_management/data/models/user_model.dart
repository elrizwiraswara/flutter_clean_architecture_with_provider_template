import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: "_id")
  final String id;

  final String name;
  final String email;
  final String avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
