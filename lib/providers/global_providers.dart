import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../cubits/cart_cubit.dart';
import '../cubits/history_cubit.dart';
import '../cubits/auth_cubit.dart';
import '../data/database/app_database.dart';
import '../data/datasource/local/token_manager.dart';
import '../data/datasource/local/user_manager.dart';
import '../data/datasource/local/local_cache_store.dart';
import '../data/datasource/remote/api_client.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/pos_repository.dart';
import '../data/repositories/sales_repository.dart';
import '../data/repositories/user_repository.dart';
import '../data/repositories/attendance_repository.dart';
import '../data/repositories/shift_repository.dart';
import '../cubits/attendance_cubit.dart';
import '../cubits/shift_cubit.dart';
import '../cubits/connectivity_cubit.dart';
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
        RepositoryProvider<UserManager>(
          create: (context) => UserManager(context.read<AppDatabase>()),
        ),
        RepositoryProvider<LocalCacheStore>(create: (_) => LocalCacheStore()),
        RepositoryProvider<Connectivity>(create: (_) => Connectivity()),
        RepositoryProvider<Dio>(
          create: (_) => Dio(
            BaseOptions(
              baseUrl:
                  dotenv.env['remote_backend'] ?? 'http://localhost:8080/api',
              connectTimeout: const Duration(seconds: 60),
              receiveTimeout: const Duration(seconds: 60),
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
                Navigator.of(navContext).popUntil((route) => route.isFirst);
              }
            },
          ),
        ),
        RepositoryProvider<IAuthRepository>(
          create: (context) => AuthRepository(
            context.read<ApiClient>(),
            context.read<TokenManager>(),
            context.read<UserManager>(),
          ),
        ),
        RepositoryProvider<IPosRepository>(
          create: (context) => PosRepository(
            context.read<ApiClient>(),
            context.read<AppDatabase>(),
          ),
        ),
        RepositoryProvider<IUserRepository>(
          create: (context) => UserRepository(context.read<UserManager>()),
        ),
        RepositoryProvider<ISalesRepository>(
          create: (context) => SalesRepository(
            context.read<ApiClient>(),
            context.read<LocalCacheStore>(),
            context.read<AppDatabase>(),
          ),
        ),
        RepositoryProvider<IAttendanceRepository>(
          create: (context) => AttendanceRepository(
            context.read<ApiClient>(),
            context.read<AppDatabase>(),
          ),
        ),
        RepositoryProvider<IShiftRepository>(
          create: (context) => ShiftRepository(
            context.read<ApiClient>(),
            context.read<AppDatabase>(),
          ),
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
            create: (context) => HistoryCubit(context.read<ISalesRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                AttendanceCubit(context.read<IAttendanceRepository>()),
          ),
          BlocProvider(
            create: (context) => ShiftCubit(context.read<IShiftRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                ConnectivityCubit(context.read<Connectivity>()),
          ),
        ],
        child: child,
      ),
    );
  }
}
