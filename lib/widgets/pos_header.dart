import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class PosHeader extends StatelessWidget {
  final VoidCallback onLeadingTap;
  final VoidCallback? onSettingsTap;
  final String title;
  final bool showBackButton;

  const PosHeader({
    super.key,
    required this.onLeadingTap,
    this.onSettingsTap,
    this.title = 'Point of Sale',
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: AppColors.surface,
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
          IconButton(
            onPressed: onLeadingTap,
            icon: Icon(
              showBackButton ? Icons.arrow_back : Icons.menu,
              color: AppColors.textSecondary,
              size: 24,
            ),
            tooltip: showBackButton ? 'Kembali' : 'Menu',
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          if (onSettingsTap != null) ...[
            const Spacer(),
            IconButton(
              onPressed: onSettingsTap,
              icon: const Icon(
                Icons.settings_outlined,
                color: AppColors.textSecondary,
                size: 24,
              ),
              tooltip: 'Pengaturan',
            ),
          ],
        ],
      ),
    );
  }
}
