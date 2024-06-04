import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_with_provider_template/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture_with_provider_template/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture_with_provider_template/features/user_management/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture_with_provider_template/features/user_management/domain/repositories/user_repository.dart';
import 'package:flutter_clean_architecture_with_provider_template/features/user_management/domain/usecases/user_usecases.dart';

class UserDetailProvider extends ChangeNotifier {
  final UserRepository userRepository;

  UserDetailProvider({required this.userRepository});

  List<UserEntity>? userList;

  void getAllUsers() async {
    try {
      var result = await GetAllUsers(userRepository).call(NoParams());

      if (result.isSuccess) {
        userList = result.data ?? [];
        notifyListeners();
      } else {
        throw APIException(
          error: result.error?.error,
          code: result.error?.code,
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
