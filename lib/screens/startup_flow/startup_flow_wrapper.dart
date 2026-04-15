import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/auth_cubit.dart';
import '../../cubits/attendance_cubit.dart';
import '../../cubits/attendance_state.dart';
import '../../cubits/shift_cubit.dart';
import '../../cubits/shift_state.dart';
import '../../cubits/connectivity_cubit.dart';
import '../../cubits/connectivity_state.dart';
import '../main_layout.dart';
import 'open_shift_screen.dart';
import 'attendance_checkin_screen.dart';

class StartupFlowWrapper extends StatefulWidget {
  const StartupFlowWrapper({super.key});

  @override
  State<StartupFlowWrapper> createState() => _StartupFlowWrapperState();
}

class _StartupFlowWrapperState extends State<StartupFlowWrapper> {
  @override
  void initState() {
    super.initState();
    _initializeStatus();
  }

  void _initializeStatus() {
    final authState = context.read<AuthCubit>().state;
    authState.maybeWhen(
      authenticated: (token, user) {
        context.read<AttendanceCubit>().checkStatus(user.id);
        context.read<ShiftCubit>().checkStatus(user.id);
      },
      orElse: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityCubit, ConnectivityState>(
      listenWhen: (previous, current) =>
          previous.isOnline != current.isOnline && current.isOnline,
      listener: (context, state) => _initializeStatus(),
      child: BlocBuilder<ShiftCubit, ShiftState>(
        builder: (context, shiftState) {
          return BlocBuilder<AttendanceCubit, AttendanceState>(
            builder: (context, attendanceState) {
              // 1. Loading State (Only if no data exists yet)
              final isInitialLoading =
                  (shiftState.isLoading && shiftState.activeShift == null) ||
                  (attendanceState.isLoading &&
                      attendanceState.todayAttendance == null);

              Widget child;
              if (isInitialLoading) {
                child = const Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Menyiapkan data toko...'),
                      ],
                    ),
                  ),
                );
              } else if (shiftState.activeShift == null ||
                  shiftState.activeShift?.startTime == null) {
                // 2. Open Shift Check
                child = const OpenShiftScreen();
              } else if (attendanceState.todayAttendance == null) {
                // 3. Attendance Check
                child = const AttendanceCheckInScreen();
              } else {
                // 4. All set, show Main Dashboard
                child = const MainLayout();
              }

              return child;
            },
          );
        },
      ),
    );
  }
}
