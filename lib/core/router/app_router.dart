import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mwan_mobile/core/constants/app_constants.dart';
import 'package:mwan_mobile/features/home/presentation/pages/cards_view.dart';
import 'package:mwan_mobile/features/home/presentation/pages/home_page.dart';
import 'package:mwan_mobile/features/home/presentation/pages/initiative_details_page.dart';
import 'package:mwan_mobile/features/home/presentation/pages/side_menu_view.dart';
import 'package:mwan_mobile/features/splash/presentation/pages/splash_page.dart';
import 'package:mwan_mobile/features/water/presentation/pages/water_storage_details_page.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  // Routes
  static const String sideMenuRoute = '/side-menu';
  static const String twoHandsRoute = '/two-hands';
  static const String usersRoute = '/users';
  static const String homeKanbanRoute = '/home-kanban';
  static const String cardsRoute = '/cards';
  static const String initiativeDetailsRoute = '/initiative-details';
  static const String waterStorageDetailsRoute = '/water-storage-details';

  static final GoRouter router = GoRouter(
    initialLocation: AppConstants.splashRoute,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppConstants.splashRoute,
        builder: (context, state) => const SplashPage(),
      ),

      // Stand-alone routes (without bottom navigation)
      GoRoute(
        path: cardsRoute,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const CardsView(),
      ),

      GoRoute(
        path: waterStorageDetailsRoute,
        parentNavigatorKey: _rootNavigatorKey,
        builder:
            (context, state) => const WaterStorageDetailsPage(
              cardData: {
                'title': 'زيادة القدرة التخزينية للمياه',
                'progress': 0.1,
                'targetDate': '05/25/2026',
                'objectives': [
                  {
                    'date': '05/25/2026',
                    'description': 'استكمال المشروع وتشغيله بالكامل',
                    'progress': 0.1,
                  },
                  {
                    'date': '05/25/2022',
                    'description':
                        'بدء تنفيذ المشروع وفق الخطة الزمنية المحددة',
                    'progress': 0.1,
                  },
                ],
              },
            ),
      ),

      // Initiative details route with path parameter
      GoRoute(
        path: '$initiativeDetailsRoute/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          // If extra data is provided, use that
          if (state.extra != null && state.extra is Map<String, dynamic>) {
            return InitiativeDetailsPage(
              initiativeData: state.extra as Map<String, dynamic>,
            );
          }
          // Otherwise create data from ID
          final initiativeData = {
            'id': id,
            'title': 'المدخرات النقدية بالعملات الصعبة',
            'status': 'متقدم',
            'progress1': 0.56,
            'progress2': 0.43,
            'isFavorite': false,
          };
          return InitiativeDetailsPage(initiativeData: initiativeData);
        },
      ),

      // Alternative route without ID for direct navigation with data
      GoRoute(
        path: initiativeDetailsRoute,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          if (state.extra != null && state.extra is Map<String, dynamic>) {
            return InitiativeDetailsPage(
              initiativeData: state.extra as Map<String, dynamic>,
            );
          }
          // Fallback data if none provided
          return const InitiativeDetailsPage(
            initiativeData: {
              'id': '0',
              'title': 'مبادرة جديدة',
              'status': 'جديد',
              'progress1': 0.0,
              'progress2': 0.0,
              'isFavorite': false,
            },
          );
        },
      ),

      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          // Extract the current route to determine which tab should be active
          final location = state.uri.toString();
          int selectedIndex = 4; // Default to home/kanban

          if (location.startsWith(sideMenuRoute)) {
            selectedIndex = 0;
          } else if (location.startsWith(twoHandsRoute)) {
            selectedIndex = 1;
          } else if (location.startsWith(usersRoute)) {
            selectedIndex = 3;
          } else if (location.startsWith(homeKanbanRoute) ||
              location == AppConstants.homeRoute) {
            selectedIndex = 4;
          }

          return HomePage(selectedIndex: selectedIndex, child: child);
        },
        routes: [
          // Main navigation routes
          GoRoute(
            path: AppConstants.homeRoute,
            redirect: (_, __) => homeKanbanRoute,
          ),
          GoRoute(
            path: homeKanbanRoute,
            builder:
                (context, state) =>
                    Container(), // Empty container for home content
          ),
          GoRoute(
            path: sideMenuRoute,
            builder: (context, state) => const SideMenuView(),
          ),
        ],
      ),
    ],
  );
}
