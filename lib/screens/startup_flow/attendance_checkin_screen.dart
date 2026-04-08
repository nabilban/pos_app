import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../cubits/attendance_cubit.dart';
import '../../cubits/auth_cubit.dart';
import '../../utils/app_colors.dart';
import '../../utils/logout_helper.dart';

class AttendanceCheckInScreen extends StatefulWidget {
  const AttendanceCheckInScreen({super.key});

  @override
  State<AttendanceCheckInScreen> createState() => _AttendanceCheckInScreenState();
}

class _AttendanceCheckInScreenState extends State<AttendanceCheckInScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _handleCheckIn(int userId) async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 50,
      );

      if (photo != null && mounted) {
        context.read<AttendanceCubit>().checkIn(userId, photo.path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengambil foto: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final userId = authState.maybeWhen(
      authenticated: (_, user) => user.id,
      orElse: () => 0,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Container(
          width: 450,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.camera_alt, size: 64, color: AppColors.primary),
              const SizedBox(height: 16),
              const Text(
                'Presensi Masuk',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Harap ambil selfie untuk verifikasi kehadiran Anda hari ini.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: () => _handleCheckIn(userId),
                  icon: const Icon(Icons.camera_front),
                  label: const Text(
                    'Ambil Selfie',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                '* Foto akan digunakan sebagai bukti absensi.',
                style: TextStyle(fontSize: 12, color: AppColors.textMuted),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => LogoutHelper.handleLogout(context),
                child: const Text('Batal & Keluar', style: TextStyle(color: AppColors.error)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
