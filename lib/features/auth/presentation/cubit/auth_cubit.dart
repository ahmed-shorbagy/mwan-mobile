import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwan_mobile/core/utils/app_logger.dart';

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String token;
  final Map<String, dynamic> user;

  const AuthAuthenticated({required this.token, required this.user});

  @override
  List<Object?> get props => [token, user];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

// Cubit
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> checkAuthStatus() async {
    try {
      emit(AuthLoading());

      // Here you would typically check for stored credentials
      // For now, we'll just emit unauthenticated
      await Future.delayed(const Duration(seconds: 1));

      emit(AuthUnauthenticated());
    } catch (e) {
      AppLogger.error('Error checking auth status: $e');
      emit(AuthError('Failed to check authentication status'));
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      emit(AuthLoading());

      // Mock API call
      await Future.delayed(const Duration(seconds: 2));

      // Simulate successful login
      final user = {
        'id': '1',
        'name': 'محمد النور',
        'email': email,
        'avatar': 'https://example.com/avatar.jpg',
      };

      final token = 'mock_token_123456';

      // Store token and user data in secure storage
      // ...

      emit(AuthAuthenticated(token: token, user: user));
    } catch (e) {
      AppLogger.error('Login error: $e');
      emit(AuthError('Failed to log in. Please check your credentials.'));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());

      // Mock registration
      await Future.delayed(const Duration(seconds: 2));

      // Simulate successful registration and auto login
      final user = {
        'id': '1',
        'name': name,
        'email': email,
        'avatar': 'https://example.com/avatar.jpg',
      };

      final token = 'mock_token_123456';

      // Store token and user data
      // ...

      emit(AuthAuthenticated(token: token, user: user));
    } catch (e) {
      AppLogger.error('Registration error: $e');
      emit(AuthError('Failed to register. Please try again.'));
    }
  }

  Future<void> logout() async {
    try {
      emit(AuthLoading());

      // Clear stored credentials
      // ...

      await Future.delayed(const Duration(milliseconds: 500));

      emit(AuthUnauthenticated());
    } catch (e) {
      AppLogger.error('Logout error: $e');
      emit(AuthError('Failed to log out.'));
    }
  }
}
