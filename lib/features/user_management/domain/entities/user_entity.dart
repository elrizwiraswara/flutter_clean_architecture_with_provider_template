import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String avatar;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return _$UserEntityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  @override
  List<Object?> get props => [id, name, email, avatar];
}
