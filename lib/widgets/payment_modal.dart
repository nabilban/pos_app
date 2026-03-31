import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/currency_util.dart';
import '../cubits/cart_cubit.dart';
import '../cubits/cart_state.dart';
import '../data/models/cart_item.dart';
import '../data/models/payment_method.dart';
import '../data/repositories/pos_repository.dart';
import 'receipt_dialog.dart';
import 'variant_selection_modal.dart';

Future<void> showPaymentModal(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _PaymentSheet(),
  );
}

class _PaymentSheet extends StatefulWidget {
  const _PaymentSheet();

  @override
  State<_PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<_PaymentSheet> {
  String _selected = '';
  final _cashController = TextEditingController();
  final _voucherController = TextEditingController();
  final _buyerController = TextEditingController();
  
  List<PaymentMethod> _paymentMethods = [];
  bool _isLoadingMethods = true;
  bool _isCheckingVoucher = false;

  @override
  void initState() {
    super.initState();
    _fetchPaymentMethods();
  }

  Future<void> _fetchPaymentMethods() async {
    try {
      final repo = context.read<IPosRepository>();
      final methods = await repo.getPaymentMethods();
      if (mounted) {
        setState(() {
          _paymentMethods = methods.where((m) => m.showInSale).toList();
          _isLoadingMethods = false;
          if (_paymentMethods.isNotEmpty) {
            _selected = _paymentMethods.first.name;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingMethods = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengambil metode pembayaran: $e')),
        );
      }
    }
  }

  Future<void> _checkVoucher(CartState state) async {
    final code = _voucherController.text.trim().toUpperCase();
    if (code.isEmpty) return;

    setState(() => _isCheckingVoucher = true);
    try {
      final repo = context.read<IPosRepository>();
      final result = await repo.checkVoucher(code, state.items);
      if (mounted) {
        context.read<CartCubit>().applyPromo(result);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Voucher "${result.name}" berhasil digunakan!')),
        );
      }
    } catch (e) {
      if (mounted) {
        String message = 'Voucher gagal diproses';
        if (e is DioException) {
          final data = e.response?.data;
          if (data is Map && data.containsKey('message')) {
            message = data['message'];
          } else if (e.response?.statusCode == 404) {
            message = 'Voucher tidak ditemukan';
          } else if (e.response?.statusCode == 400) {
            message = 'Voucher tidak memenuhi syarat';
          }
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } finally {
      if (mounted) setState(() => _isCheckingVoucher = false);
    }
  }

  @override
  void dispose() {
    _cashController.dispose();
    _voucherController.dispose();
    _buyerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {

        return SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Pilih Metode Pembayaran',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _buyerController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    labelText: 'Nama Pembeli',
                    hintText: 'Contoh: Ahmad',
                    isDense: true,
                    prefixIcon: const Icon(Icons.person_outline, size: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF2563EB),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.discount > 0) ...[
                          Text(
                            'Subtotal: ${CurrencyUtil.format(state.subtotal)}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          Text(
                            'Diskon: -${CurrencyUtil.format(state.discount)}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFFEF4444),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                        Text(
                          'Total: ${CurrencyUtil.format(state.total)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF2563EB),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Item Summary List
                if (state.items.isNotEmpty) ...[
                  const Text(
                    'Ringkasan Pesanan',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.3,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(12),
                        itemCount: state.items.length,
                        separatorBuilder: (context, index) =>
                            const Divider(height: 16, color: Color(0xFFE2E8F0)),
                        itemBuilder: (context, index) {
                          final CartItem item = state.items[index];
                          return InkWell(
                            onTap: () {
                              if (item.product.variants.isNotEmpty) {
                                VariantSelectionModal.show(
                                  context,
                                  item.product,
                                  initialOptions: item.selectedOptions,
                                  cartItem: item,
                                );
                              }
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      item.product.name.isNotEmpty
                                          ? item.product.name[0].toUpperCase()
                                          : '?',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
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
                                      if (item.selectedOptions.isNotEmpty)
                                        Text(
                                          item.selectedOptions
                                              .map((o) => o.name)
                                              .join(', '),
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Color(0xFF94A3B8),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      Text(
                                        CurrencyUtil.format(
                                            item.subtotal / item.quantity),
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFF94A3B8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    _QtyBtn(
                                      icon: Icons.remove,
                                      onTap: () => context
                                          .read<CartCubit>()
                                          .decrement(item),
                                    ),
                                    Container(
                                      width: 30,
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${item.quantity}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    _QtyBtn(
                                      icon: Icons.add,
                                      onTap: () => context
                                          .read<CartCubit>()
                                          .increment(item),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () => context
                                          .read<CartCubit>()
                                          .remove(item),
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
                  ),
                  const SizedBox(height: 20),
                ],

                // Voucher Section
                const Text(
                  'Voucher & Promo',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _voucherController,
                        textCapitalization: TextCapitalization.characters,
                        decoration: InputDecoration(
                          hintText: 'Punya kode promo?',
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      height: 42,
                      child: ElevatedButton(
                        onPressed: _isCheckingVoucher
                            ? null
                            : () => _checkVoucher(state),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E293B),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: _isCheckingVoucher
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Cek'),
                      ),
                    ),
                  ],
                ),
                if (state.appliedPromo != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle,
                            color: Color(0xFF10B981), size: 16),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Promo ${state.appliedPromo!.name} digunakan',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF10B981),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.read<CartCubit>().removePromo(),
                          child: const Text(
                            'Batal',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFFEF4444),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),

                // Payment options
                const Text(
                  'Metode Pembayaran',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 10),
                if (_isLoadingMethods)
                  const Center(child: CircularProgressIndicator())
                else if (_paymentMethods.isEmpty)
                  const Text('Tidak ada metode pembayaran yang tersedia')
                else
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _paymentMethods.map((method) {
                      IconData icon = Icons.payments_outlined;
                      if (method.name.toLowerCase().contains('qris')) {
                        icon = Icons.qr_code_scanner_outlined;
                      } else if (method.name.toLowerCase().contains('bank') ||
                          method.name.toLowerCase().contains('transfer')) {
                        icon = Icons.account_balance_outlined;
                      }

                      return SizedBox(
                        width: (MediaQuery.of(context).size.width - 60) / 3,
                        child: _PayOption(
                          label: method.name,
                          icon: icon,
                          selected: _selected == method.name,
                          onTap: () => setState(() => _selected = method.name),
                        ),
                      );
                    }).toList(),
                  ),

                // Cash input field (only for Tunai)
                if (_selected == 'Tunai') ...[
                  const SizedBox(height: 16),
                  TextField(
                    controller: _cashController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Jumlah Uang Diterima',
                      prefixText: 'Rp ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF2563EB),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: (_selected.isEmpty || _buyerController.text.trim().isEmpty)
                        ? null
                        : () {
                            Navigator.pop(context);
                            showReceiptDialog(
                              context,
                              _selected,
                              buyerName: _buyerController.text.trim(),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: const Color(0xFFE2E8F0),
                      disabledForegroundColor: const Color(0xFF94A3B8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Konfirmasi Pembayaran',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PayOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _PayOption({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFEFF6FF) : const Color(0xFFF8FAFC),
            border: Border.all(
              color: selected
                  ? const Color(0xFF2563EB)
                  : const Color(0xFFE2E8F0),
              width: selected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 28,
                color: selected
                    ? const Color(0xFF2563EB)
                    : const Color(0xFF94A3B8),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: selected
                      ? const Color(0xFF2563EB)
                      : const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QtyBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Icon(icon, size: 14, color: const Color(0xFF64748B)),
      ),
    );
  }
}
