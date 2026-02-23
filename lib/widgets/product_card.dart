import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/product.dart';

final _currencyFormatter = NumberFormat.currency(
  locale: 'id_ID',
  symbol: 'Rp ',
  decimalDigits: 0,
);

final List<Color> _cardColors = [
  const Color(0xFFEEF2FF),
  const Color(0xFFFFF7ED),
  const Color(0xFFF0FDF4),
  const Color(0xFFFDF4FF),
  const Color(0xFFFFEFF7),
  const Color(0xFFEFFFFC),
];

final List<Color> _iconColors = [
  const Color(0xFF6366F1),
  const Color(0xFFF97316),
  const Color(0xFF22C55E),
  const Color(0xFFA855F7),
  const Color(0xFFEC4899),
  const Color(0xFF14B8A6),
];

class ProductCard extends StatelessWidget {
  final Product product;
  final int index;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorIndex = index % _cardColors.length;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 64,
                decoration: BoxDecoration(
                  color: _cardColors[colorIndex],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    product.iconLabel,
                    style: TextStyle(
                      fontSize: 28,
                      color: _iconColors[colorIndex],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Color(0xFF1A1A2E),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                _currencyFormatter.format(product.price),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Color(0xFF2563EB),
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.add, color: Colors.white, size: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
