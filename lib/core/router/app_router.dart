import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mwan_mobile/core/constants/app_constants.dart';
import 'package:mwan_mobile/features/home/presentation/pages/home_page.dart';
import 'package:mwan_mobile/features/splash/presentation/pages/splash_page.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: AppConstants.splashRoute,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppConstants.splashRoute,
        builder: (context, state) => const SplashPage(),
      ),

      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return const HomePage();
        },
        routes: [
          GoRoute(
            path: AppConstants.homeRoute,
            builder:
                (context, state) =>
                    Container(), // Empty container as the HomePage handles its own content
          ),
          GoRoute(
            path: AppConstants.projectsRoute,
            builder: (context, state) => Container(),
          ),
          GoRoute(
            path: AppConstants.analyticsRoute,
            builder: (context, state) => Container(),
          ),
          GoRoute(
            path: AppConstants.settingsRoute,
            builder: (context, state) => Container(),
          ),
        ],
      ),
    ],
  );
}
