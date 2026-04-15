import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/connectivity_cubit.dart';
import '../cubits/connectivity_state.dart';
import '../data/datasource/local/local_cache_store.dart';

class NoInternetBanner extends StatelessWidget {
  final String title;
  final String message;
  final EdgeInsetsGeometry margin;
  final bool showPendingSales;

  const NoInternetBanner({
    super.key,
    this.title = 'Mode Offline',
    this.message = 'Menampilkan data dari cache. Data baru akan dimuat saat online.',
    this.margin = const EdgeInsets.fromLTRB(16, 8, 16, 8),
    this.showPendingSales = false,
  });

  static const _offlineSalesQueueKey = 'offline_sales_queue';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      builder: (context, state) {
        if (state.isOnline) {
          return const SizedBox.shrink();
        }

        final content = Container(
          margin: margin,
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
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF9A3412),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      message,
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
              if (showPendingSales)
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: context
                      .read<LocalCacheStore>()
                      .readList(_offlineSalesQueueKey),
                  builder: (context, snapshot) {
                    final count = snapshot.data?.length ?? 0;
                    if (count <= 0) {
                      return const SizedBox.shrink();
                    }
                    return Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF59E0B),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        '$count pending',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        );

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 240),
          child: content,
        );
      },
    );
  }
}
