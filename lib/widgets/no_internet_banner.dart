import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/connectivity_cubit.dart';
import '../cubits/connectivity_state.dart';
import '../cubits/history_cubit.dart';
import '../data/repositories/sales_repository.dart';

class NoInternetBanner extends StatefulWidget {
  final String title;
  final String message;
  final EdgeInsetsGeometry margin;
  final bool showPendingSales;

  const NoInternetBanner({
    super.key,
    this.title = 'Mode Offline',
    this.message =
        'Menampilkan data dari cache. Data baru akan dimuat saat online.',
    this.margin = const EdgeInsets.fromLTRB(16, 8, 16, 8),
    this.showPendingSales = false,
  });

  @override
  State<NoInternetBanner> createState() => _NoInternetBannerState();
}

class _NoInternetBannerState extends State<NoInternetBanner> {
  bool _isSyncing = false;
  String? _syncMessage;
  bool _syncSuccess = true;
  late Future<int> _pendingCountFuture;

  @override
  void initState() {
    super.initState();
    _pendingCountFuture = _loadPendingCount();
  }

  Future<int> _loadPendingCount() async {
    if (!widget.showPendingSales) return 0;
    return context.read<ISalesRepository>().getPendingOfflineSalesCount();
  }

  void _refreshPendingCount() {
    if (!mounted) return;
    setState(() {
      _pendingCountFuture = _loadPendingCount();
    });
  }

  Future<void> _syncNow() async {
    if (_isSyncing) return;

    setState(() {
      _isSyncing = true;
      _syncMessage = null;
    });

    try {
      final result = await context.read<ISalesRepository>().syncOfflineSales();

      if (!mounted) return;
      _refreshPendingCount();

      setState(() {
        _isSyncing = false;
        _syncSuccess = result.failed == 0;
        _syncMessage = _syncSuccess
            ? 'Sinkronisasi selesai - ${result.created} berhasil'
            : 'Sinkronisasi selesai dengan ${result.failed} gagal';
      });

      if (_syncSuccess) {
        context.read<HistoryCubit>().loadSales();
      }

      Future.delayed(const Duration(seconds: 3), () {
        if (!mounted) return;
        setState(() {
          _syncMessage = null;
        });
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSyncing = false;
        _syncSuccess = false;
        _syncMessage = 'Gagal sinkronisasi: $e';
      });
    }
  }

  Widget _buildCompactOfflineCard({int pendingCount = 0}) {
    return Container(
      margin: widget.margin,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF4C542), width: 1.2),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: Color(0xFFFFE4CC),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.portable_wifi_off_rounded,
              color: Color(0xFF9A3412),
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF9A3412),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  widget.message,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.2,
                    color: Color(0xFFD97706),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (widget.showPendingSales && pendingCount > 0)
            Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                '$pendingCount pending',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOnlineSyncCard({
    required int pendingCount,
    required bool isSyncing,
  }) {
    return Container(
      margin: widget.margin,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF4FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFBFD2FF), width: 1.2),
      ),
      child: Row(
        children: [
          Icon(
            isSyncing ? Icons.sync : Icons.cloud_done,
            color: const Color(0xFF2458D3),
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              isSyncing
                  ? 'Sedang menyinkronkan...'
                  : '$pendingCount transaksi offline siap disinkronkan',
              style: const TextStyle(
                color: Color(0xFF2458D3),
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 34,
            child: ElevatedButton(
              onPressed: isSyncing ? null : _syncNow,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2458D3),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(isSyncing ? 'Sync...' : 'Sync'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSyncResultCard() {
    final success = _syncSuccess;
    return Container(
      margin: widget.margin,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: success ? const Color(0xFFEAFBF2) : const Color(0xFFFFEFEF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: success ? const Color(0xFF8BE3B5) : const Color(0xFFFFB5B5),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          Icon(
            success ? Icons.check_circle : Icons.error,
            color: success ? const Color(0xFF117A47) : const Color(0xFFC62828),
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _syncMessage ?? '',
              style: TextStyle(
                color: success
                    ? const Color(0xFF117A47)
                    : const Color(0xFFC62828),
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectivityCubit, ConnectivityState>(
      listenWhen: (previous, current) => previous.isOnline != current.isOnline,
      listener: (context, state) {
        if (widget.showPendingSales) {
          _refreshPendingCount();
        }
        if (!state.isOnline && mounted) {
          setState(() {
            _isSyncing = false;
            _syncMessage = null;
          });
        }
      },
      builder: (context, state) {
        if (!widget.showPendingSales) {
          if (state.isOnline) return const SizedBox.shrink();
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 240),
            child: _buildCompactOfflineCard(),
          );
        }

        return FutureBuilder<int>(
          future: _pendingCountFuture,
          builder: (context, snapshot) {
            final pendingCount = snapshot.data ?? 0;

            Widget child;
            if (!state.isOnline) {
              child = _buildCompactOfflineCard(pendingCount: pendingCount);
            } else if (_syncMessage != null) {
              child = _buildSyncResultCard();
            } else if (_isSyncing || pendingCount > 0) {
              child = _buildOnlineSyncCard(
                pendingCount: pendingCount,
                isSyncing: _isSyncing,
              );
            } else {
              child = const SizedBox.shrink();
            }

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 240),
              child: child,
            );
          },
        );
      },
    );
  }
}
