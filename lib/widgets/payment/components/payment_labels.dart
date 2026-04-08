import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  const SectionLabel({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFFF59E0B)),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
          ),
        ),
      ],
    );
  }
}

class LabelWithAsterisk extends StatelessWidget {
  final String label;
  const LabelWithAsterisk({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
          ),
        ),
        const Text(' *', style: TextStyle(color: Color(0xFFEF4444))),
      ],
    );
  }
}
