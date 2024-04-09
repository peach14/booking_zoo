import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../featutes/auth/controler/auth_controller.dart';
import '../../featutes/auth/views/login.dart';
import '../../featutes/main/view/addmin.dart';
import '../../featutes/main/view/usersceen.dart';
import '../../splash_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    errorBuilder: (ctx, state) => Scaffold(
      body: Center(
        child: Text('Error Route: ${state.error}'),
      ),
    ),
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) {
          final session = ref.watch(sessionProvider);
          if (session.isLoading) {
            return '/';
          }

          if (session.value == null || session.value!.isEmpty) {
            return '/login';
          }

          if (session.value == 'admin') {
            return '/admin';
          }
          if (session.value != null &&
              session.value!.isNotEmpty &&
              session.value != 'admin') {
            return '/user';
          }
          return null;
        },
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: SplashScreen());
        },
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state, child) {
          return NoTransitionPage(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
              path: '/admin',
              parentNavigatorKey: _shellNavigatorKey,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: AddMinScreen())),
          GoRoute(
              path: '/login',
              parentNavigatorKey: _shellNavigatorKey,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: Login())),
          GoRoute(
              path: '/user',
              parentNavigatorKey: _shellNavigatorKey,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: UserScreen())),
        ],
      ),
    ],
  );
});

// final appRout = Provider<GoRouter>((ref) {
//   return GoRouter(
//     routes: [
//       GoRoute(
//         path: '/',
//         parentNavigatorKey: _rootNavigatorKey,
//         redirect: (context, state) async {
//           final session = ref.watch(sessionProvider);
//           if (session.isLoading) {
//             return '/';
//           }
//
//           if (session.value == null || session.value!.isEmpty) {
//             return '/login';
//           }
//
//           if (session.value == 'admin') {
//             return '/admin';
//           }
//           if (session.value != null &&
//               session.value!.isNotEmpty &&
//               session.value != 'admin') {
//             return '/user';
//           }
//         },
//         builder: (BuildContext context, GoRouterState state) {
//           return const SplashScreen();
//         },
//         routes: [
//           ShellRoute(navigatorKey: _shellNavigatorKey, routes: [
//             GoRoute(
//               path: 'user',
//               parentNavigatorKey: _shellNavigatorKey,
//               redirect: (context, state) {
//                 final session = ref.watch(sessionProvider);
//                 if (session.value == null || session.value!.isEmpty) {
//                   return '/';
//                 }
//               },
//               builder: (BuildContext context, GoRouterState state) {
//                 return const UserScreen();
//               },
//             ),
//             GoRoute(
//               path: 'admin',
//               parentNavigatorKey: _shellNavigatorKey,
//               redirect: (context, state) {
//                 final session = ref.watch(sessionProvider);
//                 if (session.value == null || session.value!.isEmpty) {
//                   return '/';
//                 }
//               },
//               builder: (BuildContext context, GoRouterState state) {
//                 return const AddMinScreen();
//               },
//             ),
//             GoRoute(
//               path: 'login',
//               parentNavigatorKey: _shellNavigatorKey,
//               builder: (BuildContext context, GoRouterState state) {
//                 return const Login();
//               },
//             ),
//           ])
//         ],
//       ),
//     ],
//   );
// });
