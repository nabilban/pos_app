import 'package:flutter/material.dart';

class PosHeader extends StatelessWidget {
  final VoidCallback onSettingsTap;

  const PosHeader({super.key, required this.onSettingsTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Text(
            'Point of Sale',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onSettingsTap,
            icon: const Icon(
              Icons.settings_outlined,
              color: Color(0xFF64748B),
              size: 24,
            ),
            tooltip: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}
