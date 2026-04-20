import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/connectivity_cubit.dart';
import '../cubits/connectivity_state.dart';
import '../cubits/history_cubit.dart';
import '../data/repositories/sales_repository.dart';

class PosStatusActions extends StatefulWidget {
  const PosStatusActions({super.key});

  @override
  State<PosStatusActions> createState() => _PosStatusActionsState();
}

class _PosStatusActionsState extends State<PosStatusActions>
    with SingleTickerProviderStateMixin {
  late final AnimationController _syncController;
  bool _isSyncing = false;
  int _pendingCount = 0;

  void _showOfflineInfo() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Mode offline aktif. Sinkronisasi tersedia saat online.'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _syncController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _loadPendingCount();
  }

  @override
  void dispose() {
    _syncController.dispose();
    super.dispose();
  }

  Future<void> _loadPendingCount() async {
    try {
      final count = await context
          .read<ISalesRepository>()
          .getPendingOfflineSalesCount();
      if (!mounted) return;
      setState(() {
        _pendingCount = count;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _pendingCount = 0;
      });
    }
  }

  Future<void> _syncNow() async {
    if (_isSyncing) return;

    setState(() {
      _isSyncing = true;
    });
    _syncController.repeat();

    try {
      final result = await context.read<ISalesRepository>().syncOfflineSales();
      if (!mounted) return;

      await _loadPendingCount();

      if (mounted && result.created > 0) {
        context.read<HistoryCubit>().loadSales();
      }

      final message = result.failed == 0
          ? 'Sinkronisasi selesai: ${result.created} transaksi tersinkron.'
          : 'Sinkronisasi selesai, ${result.failed} transaksi gagal.';

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal sinkronisasi: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isSyncing = false;
        });
        _syncController.stop();
        _syncController.reset();
      }
    }
  }

  Widget _buildSyncButton() {
    final showBadge = _pendingCount > 0 && !_isSyncing;

    return IconButton.outlined(
      onPressed: _isSyncing ? null : _syncNow,
      tooltip: _pendingCount > 0
          ? 'Sinkronkan $_pendingCount transaksi offline'
          : 'Sinkronisasi offline',
      style: IconButton.styleFrom(
        side: BorderSide(
          color: const Color(0xFF2458D3).withValues(alpha: 0.2),
          width: 1,
        ),
        shape: const CircleBorder(),
      ),
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          RotationTransition(
            turns: _syncController,
            child: Icon(
              _isSyncing ? Icons.autorenew_rounded : Icons.sync_rounded,
              color: const Color(0xFF2458D3),
              size: 20,
            ),
          ),
          if (showBadge)
            Positioned(
              right: -8,
              top: -6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                constraints: const BoxConstraints(minWidth: 14),
                decoration: const BoxDecoration(
                  color: Color(0xFFEF4444),
                  borderRadius: BorderRadius.all(Radius.circular(999)),
                ),
                child: Text(
                  _pendingCount > 9 ? '9+' : '$_pendingCount',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
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
        _loadPendingCount();
        if (!state.isOnline && _isSyncing) {
          setState(() {
            _isSyncing = false;
          });
          _syncController.stop();
          _syncController.reset();
        }
      },
      builder: (context, connectivityState) {
        final isOnline = connectivityState.isOnline;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isOnline)
              IconButton.outlined(
                onPressed: _showOfflineInfo,
                tooltip: 'Mode offline',
                style: IconButton.styleFrom(
                  side: BorderSide(
                    color: const Color(0xFFD97706).withValues(alpha: 0.2),
                    width: 1,
                  ),
                  shape: const CircleBorder(),
                ),
                icon: const Icon(
                  Icons.portable_wifi_off_rounded,
                  color: Color(0xFFD97706),
                  size: 20,
                ),
              ),
            if (isOnline && (_pendingCount > 0 || _isSyncing))
              _buildSyncButton(),
          ],
        );
      },
    );
  }
}
