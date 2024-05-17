import 'package:flutter_clean_architecture_with_provider_template/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture_with_provider_template/features/user_management/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture_with_provider_template/features/user_management/domain/repositories/user_repository.dart';

class GetAllUsers extends UseCase<Result, NoParams> {
  GetAllUsers(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<Result<List<UserEntity>>> call(NoParams params) async => _userRepository.getAllUsers();
}

class CreateUser extends UseCase<Result, UserEntity> {
  CreateUser(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<Result<UserEntity>> call(UserEntity params) async => _userRepository.createUser(params);
}

class GetUser extends UseCase<Result, String> {
  GetUser(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<Result<UserEntity>> call(String params) async => _userRepository.getUser(params);
}

class UpateUser extends UseCase<Result, UserEntity> {
  UpateUser(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<Result<bool>> call(UserEntity params) async => _userRepository.updateUser(params);
}

class DeleteUser extends UseCase<Result, String> {
  DeleteUser(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<Result<bool>> call(String params) async => _userRepository.deleteUser(params);
}
