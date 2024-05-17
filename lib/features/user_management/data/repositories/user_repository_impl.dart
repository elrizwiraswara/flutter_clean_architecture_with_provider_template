import 'package:flutter_clean_architecture_with_provider_template/features/user_management/domain/entities/user_entity.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_datasource_impl.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(this._userDatasource);

  final UserDatasourceImpl _userDatasource;

  @override
  Future<Result<List<UserEntity>>> getAllUsers() async {
    try {
      var result = await _userDatasource.getAllUser();
      var list = result.data?.map((e) => UserEntity.fromJson(e.toJson())).toList();
      return Result.success(list);
    } on APIException catch (e) {
      return Result.error(APIError.fromException(e));
    }
  }

  @override
  Future<Result<UserEntity>> createUser(UserEntity user) async {
    try {
      var result = await _userDatasource.createUser(UserModel.fromJson(user.toJson()));
      return Result.success(UserEntity.fromJson(result.data!.toJson()));
    } on APIException catch (e) {
      return Result.error(APIError.fromException(e));
    }
  }

  @override
  Future<Result<UserEntity>> getUser(String userId) async {
    try {
      var result = await _userDatasource.getUser(userId);
      return Result.success(UserEntity.fromJson(result.data!.toJson()));
    } on APIException catch (e) {
      return Result.error(APIError.fromException(e));
    }
  }

  @override
  Future<Result<bool>> updateUser(UserEntity user) async {
    try {
      var result = await _userDatasource.updateUser(UserModel.fromJson(user.toJson()));
      return Result.success(result.data);
    } on APIException catch (e) {
      return Result.error(APIError.fromException(e));
    }
  }

  @override
  Future<Result<bool>> deleteUser(String userId) async {
    try {
      var result = await _userDatasource.deleteUser(userId);
      return Result.success(result.data);
    } on APIException catch (e) {
      return Result.error(APIError.fromException(e));
    }
  }
}
