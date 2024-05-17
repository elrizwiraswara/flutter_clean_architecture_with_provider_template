import 'package:flutter_clean_architecture_with_provider_template/features/user_management/data/models/user_model.dart';

import '../../../../core/usecase/usecase.dart';

abstract class UserDatasource {
  Future<Result<List<UserModel>>> getAllUser();
  Future<Result<UserModel>> createUser(UserModel user);
  Future<Result<UserModel>> getUser(String userId);
  Future<Result<bool>> updateUser(UserModel user);
  Future<Result<bool>> deleteUser(String userId);
}
