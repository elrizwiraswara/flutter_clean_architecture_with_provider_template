import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_with_provider_template/features/user_management/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture_with_provider_template/features/user_management/presentation/providers/user_list_provider.dart';
import 'package:flutter_clean_architecture_with_provider_template/themes/app_theme.dart';
import 'package:flutter_clean_architecture_with_provider_template/widgets/app_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../widgets/user_card.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'User List',
        style: AppTheme().textTheme.titleLarge,
      ),
    );
  }

  Widget _body() {
    return Consumer<UserListProvider>(
      builder: (context, provider, _) {
        if (provider.userList == null) {
          return const CircularProgressIndicator();
        }

        if (provider.userList!.isEmpty) {
          return Text(
            '(Empty)',
            style: AppTheme().textTheme.bodySmall,
          );
        }

        return ListView.builder(
          itemCount: provider.userList!.length,
          itemBuilder: (context, i) {
            return _userCard(context, provider, provider.userList![i]);
          },
        );
      },
    );
  }

  Widget _userCard(
    BuildContext context,
    UserListProvider provider,
    UserEntity user,
  ) {
    return UserCard(
      user: user,
      onTapCard: () {
        context.go('/user-detail/:${user.id}');
      },
      onTapEdit: () {
        context.go('/user-form/:${user.id}');
      },
      onTapDelete: () {
        final navigator = Navigator.of(context);

        AppDialog.show(
          navigator,
          title: 'Confirm',
          text: 'Are you sure want to delete this user?',
          leftButtonText: 'Cancel',
          rightButtonText: 'Delete',
          onTapLeftButton: () => navigator.pop(),
          onTapRightButton: () {
            navigator.pop();
            provider.deleteUser(context, user);
          },
        );
      },
    );
  }
}
