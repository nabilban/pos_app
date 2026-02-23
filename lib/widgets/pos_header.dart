import 'package:flutter/material.dart';

class PosHeader extends StatelessWidget {
  final VoidCallback onSettingsTap;

  const PosHeader({super.key, required this.onSettingsTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Text(
            'Point of Sale',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onSettingsTap,
            icon: const Icon(
              Icons.settings_outlined,
              color: Color(0xFF1A1A2E),
              size: 24,
            ),
            tooltip: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}
