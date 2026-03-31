import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_app/cubits/cart_state.dart';
import 'package:pos_app/cubits/settings_cubit.dart';
import '../utils/currency_util.dart';
import '../cubits/cart_cubit.dart';
import '../data/models/cart_item.dart';
import '../data/models/store_info.dart';
import '../services/receipt_printer.dart';

Future<void> showReceiptDialog(BuildContext context, String paymentMethod) {
  final cubit = context.read<CartCubit>();
  final state = cubit.state;
  final items = state.items;
  final total = state.total;
  final subtotal = state.subtotal;
  final discount = state.discount;

  // Clear cart after capturing state
  cubit.clear();

  final now = DateTime.now();
  final dateStr =
      '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}  ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

  // Read store info from SettingsCubit
  final storeInfo = context.read<SettingsCubit>().state.storeInfo;

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => _ReceiptDialog(
      items: items,
      total: total,
      subtotal: subtotal,
      discount: discount,
      paymentMethod: paymentMethod,
      dateStr: dateStr,
      storeInfo: storeInfo,
    ),
  );
}

class _ReceiptDialog extends StatelessWidget {
  final List<CartItem> items;
  final double total;
  final double subtotal;
  final double discount;
  final String paymentMethod;
  final String dateStr;
  final StoreInfo storeInfo;

  const _ReceiptDialog({
    required this.items,
    required this.total,
    required this.subtotal,
    required this.discount,
    required this.paymentMethod,
    required this.dateStr,
    required this.storeInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 32,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Icon(Icons.receipt_long, color: Colors.white, size: 36),
                  SizedBox(height: 8),
                  Text(
                    storeInfo.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    storeInfo.address,
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  Text(
                    'Telp: ${storeInfo.phone}',
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),

            // Receipt body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TotalRow(label: 'Tanggal', value: dateStr),
                    _TotalRow(label: 'Metode Bayar', value: paymentMethod),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(color: Color(0xFFE2E8F0)),
                    ),

                    const Text(
                      'Pesanan',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 8),

                    ...items.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.product.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            color: Color(0xFF1A1A2E),
                                          ),
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
                                          ),
                                        Text(
                                          '${item.quantity} x ${CurrencyUtil.format(item.subtotal / item.quantity)}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF94A3B8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            Text(
                              CurrencyUtil.format(item.subtotal),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Color(0xFF1A1A2E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(color: Color(0xFFE2E8F0)),
                    ),

                    if (discount > 0) ...[
                      _TotalRow(
                        label: 'Subtotal',
                        value: CurrencyUtil.format(subtotal),
                        isBold: false,
                      ),
                      _TotalRow(
                        label: 'Diskon',
                        value: '-${CurrencyUtil.format(discount)}',
                        isBold: false,
                        color: const Color(0xFFEF4444),
                      ),
                      const SizedBox(height: 4),
                    ],

                    _TotalRow(
                      label: 'TOTAL',
                      value: CurrencyUtil.format(total),
                      isBold: true,
                      isTotal: true,
                    ),
                    const SizedBox(height: 16),

                    // Thank you note
                    Center(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0FDF4),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF22C55E),
                                  size: 16,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Pembayaran Berhasil',
                                  style: TextStyle(
                                    color: Color(0xFF22C55E),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Terima kasih telah berkunjung!',
                            style: TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Action buttons
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ReceiptPrinter.printReceipt(
                          items: items,
                          total: total,
                          subtotal: subtotal,
                          discount: discount,
                          paymentMethod: paymentMethod,
                          dateStr: dateStr,
                          storeInfo: storeInfo,
                        );
                      },
                      icon: const Icon(Icons.print, size: 20),
                      label: const Text('Cetak'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Tutup'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final bool isTotal;
  final Color? color;

  const _TotalRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.isTotal = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
              fontSize: isTotal ? 16 : 13,
              color: color ?? const Color(0xFF1A1A2E),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w700,
              fontSize: isTotal ? 18 : 13,
              color: isTotal ? const Color(0xFF2563EB) : (color ?? const Color(0xFF1A1A2E)),
            ),
          ),
        ],
      ),
    );
  }
}
