import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pos_app/screens/startup_flow/startup_flow_wrapper.dart';

import 'cubits/auth_cubit.dart';
import 'cubits/auth_state.dart';
import 'screens/login_screen.dart';
import 'utils/app_colors.dart';
import 'providers/global_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const PosApp());
}

/// Global navigator key so that Dio interceptors can navigate without a BuildContext
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class PosApp extends StatelessWidget {
  const PosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalProviders(
      child: MaterialApp(
        title: 'Point of Sale',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          textTheme: GoogleFonts.poppinsTextTheme(),
          useMaterial3: true,
        ),
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return state.maybeWhen(
              authenticated: (token, user) => const StartupFlowWrapper(),
              orElse: () => const LoginScreen(),
            );
          },
        ),
      ),
    );
  }
}
