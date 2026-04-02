import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/cart_state.dart';
import '../utils/currency_util.dart';
import '../cubits/cart_cubit.dart';
import '../cubits/auth_cubit.dart';
import '../data/models/cart_item.dart';
import '../data/models/auth_response.dart';
import '../services/receipt_printer.dart';

Future<void> showReceiptDialog(
  BuildContext context,
  String paymentMethod, {
  required String buyerName,
  String? invoiceNumber,
}) {
  final cubit = context.read<CartCubit>();
  final state = cubit.state;
  final items = state.items;
  final total = state.total;
  final subtotal = state.subtotal;
  final discount = state.discount;

  // Read user info from AuthCubit
  final user = context.read<AuthCubit>().state.maybeMap(
        authenticated: (s) => s.user,
        orElse: () => null,
      );

  final now = DateTime.now();
  final dateStr =
      '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}  ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => _ReceiptDialog(
      items: items,
      total: total,
      subtotal: subtotal,
      discount: discount,
      paymentMethod: paymentMethod,
      buyerName: buyerName,
      invoiceNumber: invoiceNumber,
      dateStr: dateStr,
      user: user,
      onClose: () {
        cubit.clear();
      },
    ),
  );
}

class _ReceiptDialog extends StatelessWidget {
  final List<CartItem> items;
  final double total;
  final double subtotal;
  final double discount;
  final String paymentMethod;
  final String buyerName;
  final String? invoiceNumber;
  final String dateStr;
  final User? user;
  final VoidCallback onClose;

  const _ReceiptDialog({
    required this.items,
    required this.total,
    required this.subtotal,
    required this.discount,
    required this.paymentMethod,
    required this.buyerName,
    this.invoiceNumber,
    required this.dateStr,
    required this.user,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final outletName = user?.outlet?.name ?? '';
    final outletAddress = user?.outlet?.address ?? '';
    final outletPhone = user?.outlet?.phone ?? '';

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 450),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF059669), Color(0xFF1E40AF)],
                    ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.receipt_long_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        outletName.trim().isNotEmpty
                            ? outletName
                            : 'Transaction Complete',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                      if (outletName.trim().isNotEmpty) ...[
                        if (outletAddress.trim().isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            outletAddress,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ],
                        if (outletPhone.trim().isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Telp: $outletPhone',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
                // Close Button
                Positioned(
                  top: 12,
                  right: 12,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        onClose();
                        Navigator.of(context).pop();
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                // Print Shortcut
                Positioned(
                  top: 12,
                  left: 12,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        if (user != null) {
                          ReceiptPrinter.printReceipt(
                            items: items,
                            total: total,
                            subtotal: subtotal,
                            discount: discount,
                            paymentMethod: paymentMethod,
                            buyerName: buyerName,
                            dateStr: dateStr,
                            user: user!,
                            invoiceNumber: invoiceNumber,
                          );
                        }
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.print_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Receipt Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (invoiceNumber != null)
                      _Row(
                        label: 'Invoice ID',
                        value: invoiceNumber!,
                        isBold: true,
                      ),
                    _Row(label: 'Tanggal', value: dateStr),
                    _Row(label: 'Metode Bayar', value: paymentMethod),
                    _Row(
                      label: 'Nama Pembeli',
                      value: buyerName.isEmpty ? '-' : buyerName,
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: _DottedDivider(),
                    ),

                    const Text(
                      'DETAIL PESANAN',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                        color: Color(0xFF94A3B8),
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 12),

                    ...items.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
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
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                  if (item.selectedOptions.isNotEmpty)
                                    Text(
                                      item.selectedOptions
                                          .map((o) => o.name)
                                          .join(', '),
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF64748B),
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
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: _DottedDivider(),
                    ),

                    if (discount > 0) ...[
                      _Row(
                        label: 'Subtotal',
                        value: CurrencyUtil.format(subtotal),
                      ),
                      _Row(
                        label: 'Diskon',
                        value: '-${CurrencyUtil.format(discount)}',
                        color: const Color(0xFFEF4444),
                      ),
                      const SizedBox(height: 4),
                    ],

                    _Row(
                      label: 'TOTAL',
                      value: CurrencyUtil.format(total),
                      isBold: true,
                      isTotal: true,
                    ),

                    const SizedBox(height: 32),

                    // Success Badge
                    Center(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFECFDF5),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle_rounded,
                                  color: Color(0xFF059669),
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Pembayaran Berhasil',
                                  style: TextStyle(
                                    color: Color(0xFF059669),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
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

            // Action Buttons
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        if (user != null) {
                          ReceiptPrinter.printReceipt(
                            items: items,
                            total: total,
                            subtotal: subtotal,
                            discount: discount,
                            paymentMethod: paymentMethod,
                            buyerName: buyerName,
                            dateStr: dateStr,
                            user: user!,
                            invoiceNumber: invoiceNumber,
                          );
                        }
                      },
                      icon: const Icon(Icons.print_rounded, size: 20),
                      label: const Text('Cetak'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        onClose();
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF059669),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Tutup',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
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

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final bool isTotal;
  final Color? color;

  const _Row({
    required this.label,
    required this.value,
    this.isBold = false,
    this.isTotal = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
              fontSize: isTotal ? 16 : 13,
              color: color ?? const Color(0xFF64748B),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w700,
              fontSize: isTotal ? 18 : 13,
              color: isTotal
                  ? const Color(0xFF059669)
                  : (color ?? const Color(0xFF1E293B)),
            ),
          ),
        ],
      ),
    );
  }
}

class _DottedDivider extends StatelessWidget {
  const _DottedDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        80,
        (index) => Expanded(
          child: Container(
            color: index % 2 == 0
                ? Colors.transparent
                : const Color(0xFFE2E8F0),
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
