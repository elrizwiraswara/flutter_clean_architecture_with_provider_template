import 'package:flutter_clean_architecture_with_provider_template/features/user_management/domain/entities/user_entity.dart';

import '../../../../core/usecase/usecase.dart';

abstract class UserRepository {
  Future<Result<List<UserEntity>>> getAllUsers();
  Future<Result<UserEntity>> createUser(UserEntity user);
  Future<Result<UserEntity>> getUser(String userId);
  Future<Result<bool>> updateUser(UserEntity user);
  Future<Result<bool>> deleteUser(String userId);
}
