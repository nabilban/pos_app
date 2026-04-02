import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/sale.dart';
import '../utils/currency_util.dart';
import '../utils/app_colors.dart';
import '../utils/date_util.dart';
import '../cubits/auth_cubit.dart';
import '../services/receipt_printer.dart';
import 'common/dotted_divider.dart';
import 'common/success_badge.dart';

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

    final dateStr = DateUtil.formatFull(sale.createdAt);

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
                      colors: AppColors.primaryGradient,
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
                      const Text(
                        'Detail Transaksi',
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
                      color: AppColors.success,
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
                      child: DottedDivider(),
                    ),

                    const Text(
                      'DETAIL PESANAN',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                        color: AppColors.textMuted,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Items list
                    ...sale.items.map((item) => _ItemRow(item: item)),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: DottedDivider(),
                    ),

                    if (sale.discountTotal > 0) ...[
                      _Row(
                        label: 'Subtotal',
                        value: CurrencyUtil.format(sale.subtotal),
                      ),
                      _Row(
                        label: 'Diskon',
                        value: '-${CurrencyUtil.format(sale.discountTotal)}',
                        color: AppColors.error,
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
                          SuccessBadge(),
                          SizedBox(height: 12),
                          Text(
                            'Transaksi Selesai',
                            style: TextStyle(
                              color: AppColors.textMuted,
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
                        backgroundColor: AppColors.success,
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
              color: color ?? AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w700,
              fontSize: isTotal ? 18 : 13,
              color: isTotal
                  ? AppColors.success
                  : (color ?? AppColors.textPrimary),
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
                    color: AppColors.textPrimary,
                  ),
                ),
                if (variantNames.isNotEmpty)
                  Text(
                    variantNames.join(', '),
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                Text(
                  '${item.quantity} x ${CurrencyUtil.format(unitPrice)}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
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
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
