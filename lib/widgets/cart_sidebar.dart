import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../cubits/cart_cubit.dart';
import '../cubits/cart_state.dart';

final _currencyFormatter = NumberFormat.currency(
  locale: 'id_ID',
  symbol: 'Rp ',
  decimalDigits: 0,
);

class CartSidebar extends StatelessWidget {
  final VoidCallback onCheckout;

  const CartSidebar({super.key, required this.onCheckout});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 12,
                offset: Offset(-2, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              // Cart header
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFF1F5F9), width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.shopping_cart_outlined,
                      color: Color(0xFF2563EB),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Keranjang',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const Spacer(),
                    if (state.items.isNotEmpty)
                      GestureDetector(
                        onTap: () => _confirmClear(context),
                        child: const Text(
                          'Hapus Semua',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFEF4444),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Cart items
              Expanded(
                child: state.items.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 48,
                              color: Color(0xFFCBD5E1),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Keranjang kosong',
                              style: TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: state.items.length,
                        separatorBuilder: (_, _) =>
                            const Divider(height: 1, color: Color(0xFFF1F5F9)),
                        itemBuilder: (context, index) {
                          final item = state.items[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.product.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          color: Color(0xFF1A1A2E),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        _currencyFormatter.format(
                                          item.subtotal,
                                        ),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF2563EB),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Quantity controls
                                Row(
                                  children: [
                                    _QtyButton(
                                      icon: Icons.remove,
                                      onTap: () => context
                                          .read<CartCubit>()
                                          .decrement(item.product.id),
                                    ),
                                    SizedBox(
                                      width: 28,
                                      child: Center(
                                        child: Text(
                                          '${item.quantity}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    _QtyButton(
                                      icon: Icons.add,
                                      onTap: () => context
                                          .read<CartCubit>()
                                          .increment(item.product.id),
                                    ),
                                    const SizedBox(width: 4),
                                    GestureDetector(
                                      onTap: () => context
                                          .read<CartCubit>()
                                          .remove(item.product.id),
                                      child: const Icon(
                                        Icons.delete_outline,
                                        color: Color(0xFFEF4444),
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),

              // Total & checkout
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Color(0xFFF1F5F9), width: 1),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF64748B),
                          ),
                        ),
                        Text(
                          _currencyFormatter.format(state.total),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: state.items.isEmpty ? null : onCheckout,
                        icon: const Icon(Icons.payment, size: 18),
                        label: const Text(
                          'Checkout',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2563EB),
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: const Color(0xFFE2E8F0),
                          disabledForegroundColor: const Color(0xFF94A3B8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _confirmClear(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus Semua?'),
        content: const Text('Semua item akan dihapus dari keranjang.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Hapus',
              style: TextStyle(color: Color(0xFFEF4444)),
            ),
          ),
        ],
      ),
    );
    if (confirm == true && context.mounted) {
      context.read<CartCubit>().clear();
    }
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 14, color: const Color(0xFF475569)),
      ),
    );
  }
}
