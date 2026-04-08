import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/cart_cubit.dart';

class AppliedPromoRow extends StatelessWidget {
  final String promoName;
  const AppliedPromoRow({super.key, required this.promoName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFBBF7D0)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_rounded, color: Color(0xFF059669), size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Promo: $promoName',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF166534),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => context.read<CartCubit>().removePromo(),
            child: const Icon(Icons.close_rounded, color: Color(0xFF166534), size: 16),
          ),
        ],
      ),
    );
  }
}
