import 'package:flutter_clean_architecture_with_provider_template/features/user_management/presentation/screens/main_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/user_management/presentation/screens/user_detail/user_detail_screen.dart';
import '../../features/user_management/presentation/screens/user_form/user_form_screen.dart';
import '../../features/user_management/presentation/screens/user_list/user_list_screen.dart';

// App routes
class AppRoutes {
  // This class is not meant to be instatiated or extended; this constructor
  // prevents instantiation and extension.
  AppRoutes._();

  static final routes = GoRouter(
    initialLocation: '/',
    routes: [_main],
  );

  static final _main = GoRoute(
    path: '/',
    builder: (context, state) {
      return const MainScreen();
    },
    redirect: (context, state) {
      // const isAuthenticated = true; // your logic to check if user is authenticated
      // if (!isAuthenticated) {
      //   return '/login';
      // } else {
      //   return null; // return "null" to display the intended route without redirecting
      // }
      return null;
    },
    routes: [
      _userList,
      _userDetail,
      _userForm,
    ],
  );

  static final _userList = GoRoute(
    path: '/user-list',
    builder: (context, state) {
      return const UserListScreen();
    },
  );

  static final _userDetail = GoRoute(
    path: '/user-detail/:id',
    builder: (context, state) {
      final id = state.pathParameters["id"]; // Get "id" param from URL

      if (id == null) {
        throw Exception('User ID not provided');
      }

      return UserDetailScreen(id: id);
    },
  );

  static final _userForm = GoRoute(
    path: '/user-form/:id',
    builder: (context, state) {
      final id = state.pathParameters["id"]; // Get "id" param from URL
      return UserFormScreen(id: id);
    },
  );
}
