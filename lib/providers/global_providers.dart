import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import '../cubits/cart_cubit.dart';
import '../cubits/settings_cubit.dart';
import '../cubits/auth_cubit.dart';
import '../data/database/app_database.dart';
import '../data/datasource/local/token_manager.dart';
import '../data/datasource/remote/api_client.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/pos_repository.dart';
import '../data/repositories/user_repository.dart';
import '../main.dart' show navigatorKey;

class GlobalProviders extends StatelessWidget {
  final Widget child;

  const GlobalProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppDatabase>(create: (_) => AppDatabase()),
        RepositoryProvider<TokenManager>(
          create: (context) => TokenManager(context.read<AppDatabase>()),
        ),
        RepositoryProvider<Dio>(
          create: (_) => Dio(
            BaseOptions(
              baseUrl:
                  dotenv.env['remote_backend'] ?? 'http://localhost:8080/api',
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
            ),
          ),
        ),
        RepositoryProvider<ApiClient>(
          create: (context) => ApiClient(
            context.read<Dio>(),
            context.read<TokenManager>(),
            onUnauthorized: () {
              // Navigate to login by triggering AuthCubit logout
              // We use navigatorKey to get a valid context outside the widget tree
              final navContext = navigatorKey.currentContext;
              if (navContext != null) {
                navContext.read<AuthCubit>().logout();
              }
            },
          ),
        ),
        RepositoryProvider<IAuthRepository>(
          create: (context) => AuthRepository(
            context.read<ApiClient>(),
            context.read<TokenManager>(),
          ),
        ),
        RepositoryProvider<IPosRepository>(
          create: (context) => PosRepository(context.read<ApiClient>()),
        ),
        RepositoryProvider<IUserRepository>(
          create: (context) => UserRepository(context.read<TokenManager>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(
              context.read<IAuthRepository>(),
              context.read<IUserRepository>(),
              context.read<TokenManager>(),
            )..checkAuthStatus(),
          ),
          BlocProvider(create: (_) => CartCubit()),
          BlocProvider(
            create: (context) => SettingsCubit(context.read<IUserRepository>()),
          ),
        ],
        child: child,
      ),
    );
  }
}
