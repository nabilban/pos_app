import 'package:flutter/material.dart';
import '../data/models/sale.dart';
import '../utils/currency_util.dart';

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
    final created = DateTime.tryParse(sale.createdAt);
    final dateStr = created != null
        ? '${created.day.toString().padLeft(2, '0')} ${_monthName(created.month)} ${created.year} ${created.hour.toString().padLeft(2, '0')}.${created.minute.toString().padLeft(2, '0')}'
        : '-';

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 460),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Header ──
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 16, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Detail Transaksi',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          sale.invoiceNumber,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF059669),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Color(0xFF94A3B8)),
                    splashRadius: 20,
                  ),
                ],
              ),
            ),

            // ── Scrollable content ──
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Info card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFF1F5F9)),
                      ),
                      child: Column(
                        children: [
                          _InfoRow(label: 'Tanggal', value: dateStr),
                          const SizedBox(height: 10),
                          _InfoRow(
                            label: 'Pembeli',
                            value: sale.customerName.isEmpty
                                ? '-'
                                : sale.customerName,
                          ),
                          const SizedBox(height: 10),
                          _InfoRow(
                            label: 'Metode Bayar',
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFECFDF5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                sale.paymentMethod?.name ?? '-',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF059669),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          _InfoRow(
                            label: 'Operator',
                            value: sale.user?.name ?? '-',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Items header
                    const Text(
                      'Item Pesanan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Item list
                    ...sale.items.map((item) => _ItemTile(item: item)),

                    // Divider
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(height: 1, color: Color(0xFFE2E8F0)),
                    ),

                    // Subtotal
                    _TotalRow(
                      label: 'Subtotal',
                      value: CurrencyUtil.format(sale.subtotal),
                    ),
                    if (sale.discountTotal > 0) ...[
                      const SizedBox(height: 6),
                      _TotalRow(
                        label: 'Diskon',
                        value: '-${CurrencyUtil.format(sale.discountTotal)}',
                        valueColor: const Color(0xFFEF4444),
                      ),
                    ],
                    const SizedBox(height: 8),
                    _TotalRow(
                      label: 'Total',
                      value: CurrencyUtil.format(sale.grandTotal),
                      isBold: true,
                      valueColor: const Color(0xFF059669),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // ── Close button ──
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF059669),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Tutup',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
    ];
    return months[month - 1];
  }
}

// ── Helper widgets ──

class _InfoRow extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? child;

  const _InfoRow({required this.label, this.value, this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF64748B),
          ),
        ),
        child ??
            Text(
              value ?? '-',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
      ],
    );
  }
}

class _ItemTile extends StatelessWidget {
  final SaleItem item;

  const _ItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final unitPrice = item.quantity > 0 ? item.subtotal / item.quantity : 0.0;
    final variantNames = item.variants
        .where((v) => v.variantOption != null)
        .map((v) => v.variantOption!.name)
        .toList();

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.product?.name ?? 'Product',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ),
              Text(
                CurrencyUtil.format(item.subtotal),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          if (variantNames.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              variantNames.join(', '),
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF64748B),
              ),
            ),
          ],
          const SizedBox(height: 4),
          Text(
            '${CurrencyUtil.format(unitPrice)} × ${item.quantity}',
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;

  const _TotalRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 16 : 14,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w500,
            color: const Color(0xFF64748B),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 18 : 14,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w700,
            color: valueColor ?? const Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }
}
