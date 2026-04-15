import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../cubits/shift_cubit.dart';
import '../cubits/shift_state.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/attendance_cubit.dart';
import '../cubits/attendance_state.dart';
import '../cubits/history_cubit.dart';
import '../cubits/history_state.dart';
import '../cubits/connectivity_cubit.dart';
import '../cubits/connectivity_state.dart';
import '../utils/app_colors.dart';
import '../utils/currency_util.dart';
import '../data/models/shift.dart';
import '../data/models/attendance.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

class ShiftScreen extends StatefulWidget {
  const ShiftScreen({super.key});

  @override
  State<ShiftScreen> createState() => _ShiftScreenState();
}

class _ShiftScreenState extends State<ShiftScreen>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  DateTime _now = DateTime.now();
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  final ValueNotifier<bool> _isSyncing = ValueNotifier<bool>(false);
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(_pulseController);

    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (mounted) {
        setState(() {
          _now = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    _isSyncing.dispose();
    super.dispose();
  }

  String _formatDuration(DateTime startTime) {
    final duration = _now.difference(startTime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '${hours}j ${minutes}m';
  }

  @override
  Widget build(BuildContext context) {
    final String baseUrl =
        dotenv.env['upload_url'] ??
        (dotenv.env['remote_backend'] ?? 'http://localhost:8080/api')
            .replaceFirst('/api', '');

    return BlocListener<ConnectivityCubit, ConnectivityState>(
      listenWhen: (previous, current) =>
          previous.isOnline != current.isOnline && current.isOnline,
      listener: (context, _) {
        final authState = context.read<AuthCubit>().state;
        authState.maybeWhen(
          authenticated: (_, user) {
            context.read<ShiftCubit>().checkStatus(user.id);
            context.read<AttendanceCubit>().checkStatus(user.id);
            context.read<HistoryCubit>().loadSales();
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: BlocBuilder<ShiftCubit, ShiftState>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 8),
                _buildTabToggle(state.selectedTab),
                Expanded(
                  child: state.selectedTab == 0
                      ? _buildShiftTab(state)
                      : _buildAttendanceTab(baseUrl),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabToggle(int selectedTab) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildTabButton(
            index: 0,
            isSelected: selectedTab == 0,
            label: 'Shift',
            icon: Icons.access_time,
          ),
          _buildTabButton(
            index: 1,
            isSelected: selectedTab == 1,
            label: 'Absensi',
            icon: Icons.assignment_turned_in_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required int index,
    required bool isSelected,
    required String label,
    required IconData icon,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.read<ShiftCubit>().setTab(index);
          if (index == 1) {
            context.read<AttendanceCubit>().loadHistory();
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? AppColors.textPrimary : AppColors.textMuted,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected
                      ? AppColors.textPrimary
                      : AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShiftTab(ShiftState state) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, historyState) {
        // Calculate stats for active shift if it exists
        double totalSales = 0;
        int totalTransactions = 0;

        if (state.activeShift != null) {
          final startTime = state.activeShift!.startTime;
          final shiftSales = historyState.sales.where((s) {
            final saleTime = DateTime.tryParse(s.createdAt);
            if (saleTime == null) return false;
            return saleTime.isAfter(startTime);
          }).toList();

          totalSales = shiftSales.fold(0.0, (sum, s) => sum + s.grandTotal);
          totalTransactions = shiftSales.length;
        }

        return ListView(
          padding: const EdgeInsets.all(24),
          children: [
            if (state.activeShift != null)
              ValueListenableBuilder<bool>(
                valueListenable: _isSyncing,
                builder: (context, syncing, _) {
                  return _buildActiveShiftCard(
                    state.activeShift!,
                    totalSales: totalSales,
                    totalTransactions: totalTransactions,
                    syncing: syncing,
                  );
                },
              )
            else
              _buildNoActiveShiftCard(),
            const SizedBox(height: 32),
            const Text(
              'Riwayat Shift',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            ...state.history
                .where((s) => s.id != state.activeShift?.id)
                .map((shift) => _buildHistoryItem(shift)),
            const SizedBox(height: 48), // Bottom padding
          ],
        );
      },
    );
  }

  Widget _buildActiveShiftCard(
    ShiftModel shift, {
    required double totalSales,
    required int totalTransactions,
    bool syncing = false,
  }) {
    final userName = context.read<AuthCubit>().state.maybeWhen(
      authenticated: (_, user) => user.name,
      orElse: () => 'Kasir',
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  FadeTransition(
                    opacity: _pulseAnimation,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Shift Sedang Berjalan',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Durasi',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  if (syncing)
                    _buildSkeletonText(width: 60, height: 20)
                  else
                    Text(
                      _formatDuration(shift.startTime),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (syncing)
                _buildSkeletonText(width: 150, height: 30)
              else
                Text(
                  userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              _buildAnimatedRefreshButton(),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Mulai: ${DateFormat('dd MMM yyyy, HH.mm').format(shift.startTime)}',
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () => _showUpdateNotesDialog(shift),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.edit_note, color: Colors.white70, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      (shift.notes != null && shift.notes!.isNotEmpty)
                          ? shift.notes!
                          : 'Tambah keterangan shift...',
                      style: TextStyle(
                        color: (shift.notes != null && shift.notes!.isNotEmpty)
                            ? Colors.white
                            : Colors.white60,
                        fontSize: 14,
                        fontStyle:
                            (shift.notes != null && shift.notes!.isNotEmpty)
                            ? FontStyle.normal
                            : FontStyle.italic,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.white38,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildStatHighlight(
                label: 'Modal Awal',
                value: CurrencyUtil.format(shift.cashIn),
                syncing: syncing,
              ),
              const SizedBox(width: 12),
              _buildStatHighlight(
                label: 'Penjualan',
                value: CurrencyUtil.format(totalSales),
                syncing: syncing,
              ),
              const SizedBox(width: 12),
              _buildStatHighlight(
                label: 'Transaksi',
                value: '${totalTransactions}x',
                syncing: syncing,
              ),
            ],
          ),
          // const SizedBox(height: 24),
          // SizedBox(
          //   width: double.infinity,
          //   height: 52,
          //   child: ElevatedButton(
          //     onPressed: () => _showCloseShiftDialog(shift.id!),
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.white,
          //       foregroundColor: AppColors.primary,
          //       elevation: 0,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //     ),
          //     child: const Text(
          //       'Tutup Shift Sekarang',
          //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildNoActiveShiftCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.no_accounts_outlined,
            size: 48,
            color: AppColors.textMuted,
          ),
          const SizedBox(height: 16),
          const Text(
            'Belum Ada Shift Aktif',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          const Text(
            'Buka shift baru untuk mulai melakukan transaksi',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _showOpenShiftDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Buka Shift Baru'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatHighlight({
    required String label,
    required String value,
    bool syncing = false,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 11),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            if (syncing)
              _buildSkeletonText(width: double.infinity, height: 16)
            else
              FittedBox(
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonText({required double width, required double height}) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _pulseAnimation.value,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(height / 4),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedRefreshButton() {
    final isPressed = ValueNotifier<bool>(false);

    return ValueListenableBuilder<bool>(
      valueListenable: _isSyncing,
      builder: (context, syncing, _) {
        return ValueListenableBuilder<bool>(
          valueListenable: isPressed,
          builder: (context, pressed, _) {
            final double rotation = syncing ? 2 : 0; // 2 turns = 720 degrees

            return GestureDetector(
              onTapDown: syncing ? null : (_) => isPressed.value = true,
              onTapUp: syncing ? null : (_) => isPressed.value = false,
              onTapCancel: syncing ? null : () => isPressed.value = false,
              onTap: syncing
                  ? null
                  : () async {
                      _isSyncing.value = true;
                      final startTime = DateTime.now();

                      final authState = context.read<AuthCubit>().state;
                      await authState.maybeWhen(
                        authenticated: (_, user) async {
                          await Future.wait([
                            context.read<ShiftCubit>().checkStatus(user.id),
                            context.read<HistoryCubit>().loadSales(),
                          ]);
                        },
                        orElse: () async {},
                      );

                      // Ensure at least 800ms of animation
                      final elapsed = DateTime.now().difference(startTime);
                      if (elapsed < const Duration(milliseconds: 800)) {
                        await Future.delayed(
                          Duration(milliseconds: 800 - elapsed.inMilliseconds),
                        );
                      }

                      if (mounted) _isSyncing.value = false;
                    },
              child: AnimatedScale(
                scale: pressed ? 0.92 : 1.0,
                duration: const Duration(milliseconds: 100),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: AnimatedRotation(
                    turns: rotation,
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeInOutBack,
                    child: Icon(
                      Icons.sync,
                      size: 20,
                      color: syncing ? AppColors.textMuted : AppColors.primary,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHistoryItem(ShiftModel shift) {
    final userName = context.read<AuthCubit>().state.maybeWhen(
      authenticated: (_, user) => user.name,
      orElse: () => 'Kasir',
    );

    final duration = shift.endTime?.difference(shift.startTime);
    final durStr = duration != null
        ? '${duration.inHours}j ${duration.inMinutes % 60}m'
        : '--';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                CurrencyUtil.format(shift.cashOut ?? 0),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${DateFormat('dd MMM yyyy, HH.mm').format(shift.startTime)} → ${shift.endTime != null ? DateFormat('HH.mm').format(shift.endTime!) : '--'}',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              if (shift.cashOut != null)
                Text(
                  shift.cashOut! >= shift.cashIn
                      ? '+${CurrencyUtil.format(shift.cashOut! - shift.cashIn)}'
                      : '-${CurrencyUtil.format(shift.cashIn - shift.cashOut!)}',
                  style: TextStyle(
                    color: shift.cashOut! >= shift.cashIn
                        ? AppColors.success
                        : AppColors.error,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Durasi: $durStr',
            style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
          ),
          if (shift.notes != null && shift.notes!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.edit_note,
                  color: AppColors.textMuted,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '"${shift.notes}"',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () => _showUpdateNotesDialog(shift),
              borderRadius: BorderRadius.circular(8),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Edit keterangan',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceTab(String baseUrl) {
    return BlocBuilder<AttendanceCubit, AttendanceState>(
      builder: (context, state) {
        if (state.isLoading && state.history.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.all(24),
          children: [
            _buildTodayAttendanceSection(state),
            const SizedBox(height: 32),
            const Text(
              'Riwayat Absensi',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            if (state.history.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Text('Belum ada riwayat absensi'),
                ),
              )
            else
              ...state.history.map(
                (a) => _buildAttendanceHistoryItem(a, baseUrl),
              ),
            const SizedBox(height: 48),
          ],
        );
      },
    );
  }

  Widget _buildTodayAttendanceSection(AttendanceState state) {
    final today = DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now());
    final att = state.todayAttendance;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Absensi Hari Ini',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            today,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          _buildAttendanceStatusRow(
            label: 'Absen Masuk',
            time: att?.checkIn != null
                ? DateFormat(
                    'HH:mm',
                  ).format(DateTime.parse(att!.checkIn!).toLocal())
                : null,
            subtitle: att?.checkIn != null ? 'Terabsen' : 'Belum absen masuk',
            onPressed: att?.checkIn == null
                ? () => _handleAttendanceCheckIn()
                : null,
            icon: Icons.login_rounded,
          ),
          const Divider(height: 32),
          _buildAttendanceStatusRow(
            label: 'Absen Pulang',
            time: att?.checkOut != null
                ? DateFormat(
                    'HH:mm',
                  ).format(DateTime.parse(att!.checkOut!).toLocal())
                : null,
            subtitle: att?.checkOut != null
                ? 'Selesai'
                : (att?.checkIn != null
                      ? 'Siap absen pulang'
                      : 'Absen masuk dulu'),
            onPressed: (att?.checkIn != null && att?.checkOut == null)
                ? () => _handleAttendanceCheckOut(att!.id!)
                : null,
            icon: Icons.logout_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceStatusRow({
    required String label,
    String? time,
    required String subtitle,
    VoidCallback? onPressed,
    required IconData icon,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.textSecondary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                time != null ? '$subtitle $time' : subtitle,
                style: TextStyle(
                  color: time != null ? AppColors.success : AppColors.textMuted,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        if (onPressed != null)
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(label),
          )
        else if (time != null)
          const Icon(Icons.check_circle, color: AppColors.success)
        else
          const Text('—', style: TextStyle(color: AppColors.textMuted)),
      ],
    );
  }

  Widget _buildAttendanceHistoryItem(AttendanceModel a, String baseUrl) {
    final checkIn = a.checkIn != null
        ? DateTime.parse(a.checkIn!).toLocal()
        : null;
    final checkOut = a.checkOut != null
        ? DateTime.parse(a.checkOut!).toLocal()
        : null;

    String duration = '';
    if (checkIn != null && checkOut != null) {
      final diff = checkOut.difference(checkIn);
      duration = 'Durasi: ${diff.inHours}j ${diff.inMinutes % 60}m';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  checkIn != null
                      ? DateFormat('EEE, dd MMM yyyy').format(checkIn)
                      : '-',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 4,
                  children: [
                    if (checkIn != null)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.circle,
                            size: 8,
                            color: AppColors.success,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Masuk: ${DateFormat('HH.mm').format(checkIn)}',
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    if (checkOut != null)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.circle,
                            size: 8,
                            color: AppColors.warning,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Pulang: ${DateFormat('HH.mm').format(checkOut)}',
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                  ],
                ),
                if (duration.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    duration,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Row(
            children: [
              if (a.photoIn != null && a.photoIn!.isNotEmpty)
                _buildAttendancePhoto(baseUrl + a.photoIn!, 'masuk'),
              if (a.photoOut != null && a.photoOut!.isNotEmpty) ...[
                const SizedBox(width: 8),
                _buildAttendancePhoto(baseUrl + a.photoOut!, 'pulang'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttendancePhoto(String url, String label) {
    // Basic image display, would need full URL in real app
    return Stack(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFFF1F5F9),
            image: DecorationImage(
              image: NetworkImage(url), // Placeholder for real implementation
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(12),
              ),
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 8),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleAttendanceCheckIn() async {
    final userId = context.read<AuthCubit>().state.maybeWhen(
      authenticated: (_, user) => user.id,
      orElse: () => 0,
    );
    if (userId == 0) return;

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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal mengambil foto: $e')));
      }
    }
  }

  Future<void> _handleAttendanceCheckOut(int attendanceId) async {
    final userId = context.read<AuthCubit>().state.maybeWhen(
      authenticated: (_, user) => user.id,
      orElse: () => 0,
    );
    if (userId == 0) return;

    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 50,
      );

      if (photo != null && mounted) {
        context.read<AttendanceCubit>().checkOut(
          attendanceId,
          userId,
          photo.path,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal mengambil foto: $e')));
      }
    }
  }

  void _showOpenShiftDialog() {
    final TextEditingController cashController = TextEditingController();
    final TextEditingController notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Buka Shift'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: cashController,
                decoration: const InputDecoration(
                  labelText: 'Modal Awal',
                  prefixText: 'Rp ',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: notesController,
                decoration: const InputDecoration(labelText: 'Catatan'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              final authState = this.context.read<AuthCubit>().state;
              authState.maybeWhen(
                authenticated: (_, user) {
                  this.context.read<ShiftCubit>().openShift(
                    user.id,
                    double.tryParse(cashController.text) ?? 0,
                    notesController.text,
                  );
                },
                orElse: () {},
              );
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showUpdateNotesDialog(ShiftModel shift) {
    if (shift.id == null) return;
    final TextEditingController notesController = TextEditingController(
      text: shift.notes,
    );

    final userName = context.read<AuthCubit>().state.maybeWhen(
      authenticated: (_, user) => user.name,
      orElse: () => 'Kasir',
    );

    final timeStr = DateFormat('dd MMM yyyy, HH.mm').format(shift.startTime);

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(28),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Edit Keterangan Shift',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$userName · $timeStr',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: notesController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFF10B981),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFF10B981),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBEB),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFFEF3C7)),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Color(0xFFD97706),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Hanya keterangan yang bisa diedit. Data nominal tidak dapat diubah.',
                          style: TextStyle(
                            color: Color(0xFF92400E),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: Color(0xFFE5E7EB)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Batal',
                          style: TextStyle(
                            color: Color(0xFF374151),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<ShiftCubit>().updateNotes(
                            shift.id!,
                            notesController.text,
                          );
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF049C6B),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Simpan',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
