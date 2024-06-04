import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_with_provider_template/features/user_management/presentation/screens/user_list/user_list_screen.dart';
import 'package:flutter_clean_architecture_with_provider_template/services/locator/service_locator.dart';
import 'package:flutter_clean_architecture_with_provider_template/themes/app_theme.dart';
import 'package:provider/provider.dart';

import '../providers/main_provider.dart';
import 'user_form/user_form_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  Widget _body() {
    return Consumer<MainProvider>(
      builder: (context, model, _) {
        return [
          const UserListScreen(),
          const UserFormScreen(),
        ].elementAt(model.currentIndex);
      },
    );
  }

  Widget _bottomNavBar() {
    return BottomNavigationBar(
      onTap: (index) {
        final mainProvider = sl<MainProvider>();
        mainProvider.onChangedPage(index);
      },
      items: [
        BottomNavigationBarItem(
          label: 'List',
          activeIcon: Icon(
            Icons.list_alt_rounded,
            color: AppTheme().colorScheme.primary,
          ),
          icon: Icon(
            Icons.list_alt_rounded,
            color: AppTheme().colorScheme.surface,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Form',
          activeIcon: Icon(
            Icons.edit_note_rounded,
            color: AppTheme().colorScheme.primary,
          ),
          icon: Icon(
            Icons.edit_note_rounded,
            color: AppTheme().colorScheme.surface,
          ),
        ),
      ],
    );
  }
}
