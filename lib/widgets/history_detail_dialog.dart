import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/sale.dart';
import '../utils/currency_util.dart';
import '../cubits/auth_cubit.dart';
import '../services/receipt_printer.dart';

class HistoryDetailDialog extends StatelessWidget {
  final Sale sale;

  const HistoryDetailDialog({super.key, required this.sale});

  static Future<void> show(BuildContext context, Sale sale) {
    return showDialog(
      context: context,
      builder: (_) => HistoryDetailDialog(sale: sale),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Read user info from AuthCubit to get current Outlet/Store info
    final currentUser = context.read<AuthCubit>().state.maybeMap(
          authenticated: (s) => s.user,
          orElse: () => null,
        );

    final created = DateTime.tryParse(sale.createdAt);
    final dateStr = created != null
        ? '${created.day.toString().padLeft(2, '0')}/${created.month.toString().padLeft(2, '0')}/${created.year}  ${created.hour.toString().padLeft(2, '0')}:${created.minute.toString().padLeft(2, '0')}'
        : '-';

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
            // ── Gradient Header ──
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
                        'Detail Transaksi',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        sale.invoiceNumber,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // Close icon button top right
                Positioned(
                  top: 12,
                  right: 12,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
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
                // Print icon button top left
                Positioned(
                  top: 12,
                  left: 12,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        if (currentUser != null) {
                          ReceiptPrinter.printSale(
                            sale: sale,
                            user: currentUser,
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

            // ── Scrollable Receipt Body ──
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Row(label: 'Tanggal', value: dateStr),
                    _Row(
                      label: 'Metode Bayar',
                      value: sale.paymentMethod?.name ?? '-',
                      color: const Color(0xFF059669),
                      isBold: true,
                    ),
                    _Row(
                      label: 'Nama Pembeli',
                      value: sale.customerName.isEmpty ? '-' : sale.customerName,
                    ),
                    _Row(
                      label: 'Operator',
                      value: sale.user?.name ?? '-',
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

                    // Items list
                    ...sale.items.map((item) => _ItemRow(item: item)),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: _DottedDivider(),
                    ),

                    if (sale.discountTotal > 0) ...[
                      _Row(
                        label: 'Subtotal',
                        value: CurrencyUtil.format(sale.subtotal),
                      ),
                      _Row(
                        label: 'Diskon',
                        value: '-${CurrencyUtil.format(sale.discountTotal)}',
                        color: const Color(0xFFEF4444),
                      ),
                      const SizedBox(height: 4),
                    ],

                    _Row(
                      label: 'TOTAL',
                      value: CurrencyUtil.format(sale.grandTotal),
                      isBold: true,
                      isTotal: true,
                    ),

                    const SizedBox(height: 32),

                    // Success Badge
                    const Center(
                      child: Column(
                        children: [
                          _SuccessBadge(),
                          SizedBox(height: 12),
                          Text(
                            'Transaksi Selesai',
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

            // ── Action Buttons ──
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        if (currentUser != null) {
                          ReceiptPrinter.printSale(
                            sale: sale,
                            user: currentUser,
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
                      onPressed: () => Navigator.pop(context),
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

// ── Components matching receipt_dialog.dart ──

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

class _ItemRow extends StatelessWidget {
  final SaleItem item;

  const _ItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final unitPrice = item.quantity > 0 ? item.subtotal / item.quantity : 0.0;
    final variantNames = item.variants
        .where((v) => v.variantOption != null)
        .map((v) => v.variantOption!.name)
        .toList();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product?.name ?? 'Unknown Product',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFF1E293B),
                  ),
                ),
                if (variantNames.isNotEmpty)
                  Text(
                    variantNames.join(', '),
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF64748B),
                    ),
                  ),
                Text(
                  '${item.quantity} x ${CurrencyUtil.format(unitPrice)}',
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
            color: index % 2 == 0 ? Colors.transparent : const Color(0xFFE2E8F0),
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

class _SuccessBadge extends StatelessWidget {
  const _SuccessBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
    );
  }
}
