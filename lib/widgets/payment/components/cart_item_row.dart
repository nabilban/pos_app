import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/cart_cubit.dart';
import '../../../data/models/cart_item.dart';
import '../../../utils/currency_util.dart';
import '../../variant_selection_modal.dart';

class CartItemRow extends StatelessWidget {
  final CartItem item;
  final Map<int, double> priceOverrides;

  const CartItemRow({
    super.key,
    required this.item,
    this.priceOverrides = const {},
  });

  double get _unitPrice {
    final override = priceOverrides[item.product.id];
    final base = override ?? item.product.price;
    final variants = item.selectedOptions.fold(0.0, (s, o) => s + o.additionalPrice);
    return base + variants;
  }

  double get _rowTotal => _unitPrice * item.quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.icecream_outlined, color: Color(0xFF94A3B8)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.product.name,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, color: Color(0xFF059669), size: 20),
                          onPressed: () => VariantSelectionModal.show(
                            context,
                            item.product,
                            initialOptions: item.selectedOptions,
                            cartItem: item,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 20),
                          onPressed: () => context.read<CartCubit>().remove(item),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ],
                ),
                if (item.selectedOptions.isNotEmpty)
                  Text(
                    item.selectedOptions.map((o) => o.name).join(', '),
                    style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                  ),
                const SizedBox(height: 4),
                Text(
                  CurrencyUtil.format(_unitPrice),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF059669),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        QtyActionBtn(
                          icon: Icons.remove,
                          onPressed: () => context.read<CartCubit>().decrement(item),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '${item.quantity}',
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                          ),
                        ),
                        QtyActionBtn(
                          icon: Icons.add,
                          onPressed: () => context.read<CartCubit>().increment(item),
                          isAdd: true,
                        ),
                      ],
                    ),
                    Text(
                      CurrencyUtil.format(_rowTotal),
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QtyActionBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isAdd;

  const QtyActionBtn({
    super.key,
    required this.icon,
    required this.onPressed,
    this.isAdd = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isAdd ? const Color(0xFF059669) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: isAdd ? null : Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Icon(
          icon,
          size: 16,
          color: isAdd ? Colors.white : const Color(0xFF64748B),
        ),
      ),
    );
  }
}
