import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cubits/cart_cubit.dart';
import 'cubits/settings_cubit.dart';
import 'repositories/pos_repository.dart';
import 'screens/pos_screen.dart';

void main() {
  runApp(const PosApp());
}

class PosApp extends StatelessWidget {
  const PosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PosRepository(),
      child: MultiBlocProvider(
        providers: [
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
          home: const PosScreen(),
        ),
      ),
    );
  }
}
