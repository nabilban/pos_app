import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import 'cubits/cart_cubit.dart';
import 'cubits/settings_cubit.dart';
import 'data/repositories/pos_repository.dart';
import 'screens/pos_screen.dart';

import 'data/database/app_database.dart';
import 'data/datasource/local/token_manager.dart';
import 'data/datasource/remote/api_client.dart';
import 'data/repositories/auth_repository.dart';
import 'cubits/auth_cubit.dart';
import 'cubits/auth_state.dart';
import 'screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const PosApp());
}

class PosApp extends StatelessWidget {
  const PosApp({super.key});

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
                  dotenv.env['local_backend'] ?? 'http://localhost:8080/api/',
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
          create: (context) =>
              ApiClient(context.read<Dio>(), context.read<TokenManager>()),
        ),
        RepositoryProvider<IAuthRepository>(
          create: (context) => AuthRepository(
            context.read<ApiClient>(),
            context.read<TokenManager>(),
          ),
        ),
        RepositoryProvider<IPosRepository>(create: (_) => PosRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(
              context.read<AuthRepository>(),
              context.read<TokenManager>(),
            )..checkAuthStatus(),
          ),
          BlocProvider(create: (_) => CartCubit()),
          BlocProvider(
            create: (context) =>
                SettingsCubit(RepositoryProvider.of<PosRepository>(context)),
          ),
        ],
        child: MaterialApp(
          title: 'Point of Sale',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF2563EB),
            ),
            textTheme: GoogleFonts.poppinsTextTheme(),
            useMaterial3: true,
          ),
          home: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return state.maybeWhen(
                authenticated: (_) => const PosScreen(),
                orElse: () => const LoginScreen(),
              );
            },
          ),
        ),
      ),
    );
  }
}
