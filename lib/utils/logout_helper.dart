import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/connectivity_cubit.dart';
import '../cubits/shift_cubit.dart';
import '../widgets/shift/close_shift_dialog.dart';

class LogoutHelper {
  static void handleLogout(BuildContext context) {
    if (!_isOnline(context)) {
      _showOnlineRequiredMessage(context);
      return;
    }

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
              if (!_isOnline(context)) {
                Navigator.pop(context);
                _showOnlineRequiredMessage(context);
                return;
              }

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

  static bool _isOnline(BuildContext context) {
    try {
      return context.read<ConnectivityCubit>().state.isOnline;
    } catch (_) {
      // If connectivity state is unavailable, do not block the logout flow.
      return true;
    }
  }

  static void _showOnlineRequiredMessage(BuildContext context) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger != null) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Butuh koneksi internet untuk tutup shift dan logout.',
          ),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tidak Ada Koneksi'),
        content: const Text(
          'Tutup shift dan logout hanya bisa dilakukan saat online.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
