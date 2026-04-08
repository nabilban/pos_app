import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/shift_cubit.dart';
import '../widgets/shift/close_shift_dialog.dart';

class LogoutHelper {
  static void handleLogout(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final shiftCubit = context.read<ShiftCubit>();
    final activeShift = shiftCubit.state.activeShift;

    if (activeShift != null) {
      // If there is an active shift, show the close shift dialog first
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CloseShiftDialog(
          shift: activeShift,
          onSuccess: () {
            // After shift is closed successfully, perform logout
            authCubit.logout();
          },
        ),
      );
    } else {
      // If no active shift, logout directly
      _confirmDirectLogout(context, authCubit);
    }
  }

  static void _confirmDirectLogout(BuildContext context, AuthCubit authCubit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Keluar'),
        content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              authCubit.logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
            ),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }
}
