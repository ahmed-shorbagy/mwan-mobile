class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // API Constants
  static const String baseUrl = 'https://api.example.com';
  static const int connectionTimeout = 30000; // milliseconds
  static const int receiveTimeout = 30000; // milliseconds

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'app_theme';
  static const String languageKey = 'app_language';
  static const String isFirstTimeKey = 'is_first_time';

  // Default Values
  static const String defaultLocale = 'ar';
  static const String defaultTheme = 'dark';

  // Routes
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';
  static const String projectsRoute = '/projects';
  static const String analyticsRoute = '/analytics';
  static const String chatRoute = '/chat';
  static const String profileRoute = '/profile';
  static const String settingsRoute = '/settings';
}
