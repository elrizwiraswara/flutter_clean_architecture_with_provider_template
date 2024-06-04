import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_with_provider_template/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture_with_provider_template/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture_with_provider_template/features/user_management/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture_with_provider_template/features/user_management/domain/repositories/user_repository.dart';
import 'package:flutter_clean_architecture_with_provider_template/features/user_management/domain/usecases/user_usecases.dart';
import 'package:flutter_clean_architecture_with_provider_template/themes/app_theme.dart';
import 'package:flutter_clean_architecture_with_provider_template/widgets/app_dialog.dart';

class UserListProvider extends ChangeNotifier {
  final UserRepository userRepository;

  UserListProvider({required this.userRepository});

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

  void deleteUser(
    BuildContext context,
    UserEntity user,
  ) async {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    // Show progress indicator dialog
    AppDialog.showDialogProgress(navigator);

    var result = await DeleteUser(userRepository).call(user.id);

    // Close progress indicator dialog
    navigator.pop();

    if (result.isSuccess) {
      messenger.showSnackBar(
        SnackBar(
            content: Text(
          'User ${user.name} deleted',
          style: AppTheme().textTheme.bodyLarge,
        )),
      );
    } else {
      messenger.showSnackBar(
        SnackBar(content: Text('Failed to delete user ${user.name}, Try again later. [${result.error?.code}]')),
      );
    }
  }
}
