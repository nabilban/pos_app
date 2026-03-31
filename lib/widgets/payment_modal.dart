import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/currency_util.dart';
import '../cubits/cart_cubit.dart';
import '../cubits/cart_state.dart';
import '../data/models/cart_item.dart';
import '../data/models/payment_method.dart';
import '../data/repositories/pos_repository.dart';
import '../data/models/promo.dart';
import 'receipt_dialog.dart';

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
  List<Promo> _promos = [];
  bool _isCheckingVoucher = false;
  int _currentStep = 0; // 0: Confirmation, 1: Payment
  String _selectedPriceLevel = 'Normal';

  @override
  void initState() {
    super.initState();
    _fetchPaymentMethods();
    _fetchPromos();
  }

  Future<void> _fetchPromos() async {
    try {
      final repo = context.read<IPosRepository>();
      final promos = await repo.getPromos();
      if (mounted) setState(() => _promos = promos);
    } catch (_) {}
  }

  Future<void> _fetchPaymentMethods() async {
    try {
      final repo = context.read<IPosRepository>();
      final methods = await repo.getPaymentMethods();
      if (mounted) {
        setState(() {
          _paymentMethods = methods.where((m) => m.showInSale).toList();
          if (_paymentMethods.isNotEmpty) {
            _selected = _paymentMethods.first.name;
          }
        });
      }
    } catch (e) {
      if (mounted) {
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
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
                child: Row(
                  children: [
                    if (_currentStep == 1)
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, size: 20),
                        onPressed: () => setState(() => _currentStep = 0),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    if (_currentStep == 1) const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _currentStep == 0 ? 'Keranjang' : 'Pembayaran',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                          if (_currentStep == 0)
                            Text(
                              '${state.items.length} produk',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF94A3B8),
                              ),
                            ),
                          if (_currentStep == 1)
                            Text(
                              'Atas nama: ${_buyerController.text}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF94A3B8),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (_currentStep == 0)
                      IconButton(
                        icon: const Icon(Icons.close_rounded, size: 28),
                        onPressed: () => Navigator.pop(context),
                        color: const Color(0xFF94A3B8),
                      ),
                  ],
                ),
              ),
              const Divider(height: 1),

              // Content
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_currentStep == 0) ...[
                        _buildCartStep(state),
                      ] else ...[
                        _buildPaymentStep(state),
                      ],
                    ],
                  ),
                ),
              ),

              // Footer Button
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: _GreenPrimaryButton(
                  label: _currentStep == 0
                      ? 'Lanjut Pembayaran'
                      : 'Proses Transaksi',
                  icon: _currentStep == 0 ? Icons.arrow_forward : Icons.check,
                  onPressed: (_currentStep == 0 &&
                          _buyerController.text.trim().isEmpty)
                      ? null
                      : (_currentStep == 0
                          ? () => setState(() => _currentStep = 1)
                          : () {
                              Navigator.pop(context);
                              showReceiptDialog(
                                context,
                                _selected,
                                buyerName: _buyerController.text.trim(),
                              );
                            }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCartStep(CartState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _LabelWithAsterisk(label: 'Nama Pembeli'),
        const SizedBox(height: 8),
        TextField(
          controller: _buyerController,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: 'Contoh: Ahmad',
            isDense: true,
            prefixIcon: const Icon(Icons.person_outline, size: 24),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Product List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final item = state.items[index];
            return _CartItemRow(item: item);
          },
        ),
        const SizedBox(height: 24),

        // Price Level Dropdown
        const _SectionLabel(icon: Icons.monetization_on, label: 'Tingkat Harga'),
        const SizedBox(height: 8),
        _buildDropdownSelector(
          value: _selectedPriceLevel,
          items: ['Normal', 'Gojek', 'Grab', 'Take Away'],
          onChanged: (val) => setState(() => _selectedPriceLevel = val!),
        ),
        const SizedBox(height: 20),

        // Promos Available
        const _SectionLabel(icon: Icons.sell, label: 'Promo Tersedia'),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Text(
            _promos.isEmpty
                ? 'Tidak ada promo untuk keranjang ini'
                : _promos.map((p) => p.name).join(', '),
            style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
          ),
        ),
        const SizedBox(height: 20),

        // Voucher Input
        const _SectionLabel(icon: Icons.confirmation_number, label: 'Kode Voucher'),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE2E8F0)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _voucherController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan kode voucher',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: _isCheckingVoucher ? null : () => _checkVoucher(state),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  child: const Text('Pakai'),
                ),
              ),
            ],
          ),
        ),
        if (state.appliedPromo != null) ...[
          const SizedBox(height: 8),
          _AppliedPromoRow(promoName: state.appliedPromo!.name),
        ],
        const SizedBox(height: 24),

        // Summary
        _SummaryRow(label: 'Subtotal', value: CurrencyUtil.format(state.subtotal)),
        if (state.discount > 0)
          _SummaryRow(
            label: 'Diskon',
            value: '-${CurrencyUtil.format(state.discount)}',
            valueColor: const Color(0xFFEF4444),
          ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            Text(
              CurrencyUtil.format(state.total),
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF10B981)),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildPaymentStep(CartState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Total Tagihan Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            color: const Color(0xFFF0FDF4),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              const Text('Total Tagihan',
                  style: TextStyle(fontSize: 14, color: Color(0xFF10B981))),
              const SizedBox(height: 8),
              Text(
                CurrencyUtil.format(state.total),
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF065F46)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        const Text('Metode Pembayaran',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        _buildDropdownSelector(
          value: _selected,
          items: _paymentMethods.map((e) => e.name).toList(),
          onChanged: (val) => setState(() => _selected = val!),
        ),
        const SizedBox(height: 16),

        const Text('Nominal Dibayar',
            style: TextStyle(fontSize: 14, color: Color(0xFF64748B))),
        const SizedBox(height: 8),
        TextField(
          controller: _cashController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefixText: 'Rp ',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 12),

        // Quick amount chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildAmountChip(state.total),
              _buildAmountChip(50000),
              _buildAmountChip(100000),
              _buildAmountChip(150000),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Split Payment Button UI
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE2E8F0), style: BorderStyle.none),
            // Custom dashed border logic if needed, or just standard rounded with dash effect
            borderRadius: BorderRadius.circular(12),
          ),
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFE2E8F0), style: BorderStyle.solid),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text('+ Tambah Metode Pembayaran (Split)',
                style: TextStyle(color: Color(0xFF64748B), fontSize: 13)),
          ),
        ),
        const SizedBox(height: 24),

        // Summary Change
        _SummaryRow(label: 'Total Dibayar', value: CurrencyUtil.format(_getPaidAmount())),
        const Divider(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Kembalian',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            Text(
              CurrencyUtil.format(_getChange(state.total)),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF10B981)),
            ),
          ],
        ),
      ],
    );
  }

  double _getPaidAmount() {
    return double.tryParse(_cashController.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
        0;
  }

  double _getChange(double total) {
    final paid = _getPaidAmount();
    return paid > total ? paid - total : 0;
  }

  Widget _buildAmountChip(double amount) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        label: Text(CurrencyUtil.format(amount)),
        onPressed: () {
          setState(() {
            _cashController.text = amount.toInt().toString();
          });
        },
        backgroundColor: Colors.white,
        side: const BorderSide(color: Color(0xFFE2E8F0)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _buildDropdownSelector({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : (items.isNotEmpty ? items.first : null),
          isExpanded: true,
          onChanged: onChanged,
          items: items.map((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(val),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SectionLabel({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFFF59E0B)),
        const SizedBox(width: 6),
        Text(label,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E))),
      ],
    );
  }
}

class _LabelWithAsterisk extends StatelessWidget {
  final String label;
  const _LabelWithAsterisk({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E))),
        const Text(' *', style: TextStyle(color: Color(0xFFEF4444))),
      ],
    );
  }
}

class _GreenPrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  const _GreenPrimaryButton({
    required this.label,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B981),
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFFE2E8F0),
          disabledForegroundColor: const Color(0xFF94A3B8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
            const SizedBox(width: 8),
            Icon(icon, size: 20),
          ],
        ),
      ),
    );
  }
}

class _CartItemRow extends StatelessWidget {
  final CartItem item;
  const _CartItemRow({required this.item});

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
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4))
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
                      child: Text(item.product.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline,
                          color: Color(0xFFEF4444), size: 20),
                      onPressed: () => context.read<CartCubit>().remove(item),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                if (item.selectedOptions.isNotEmpty)
                  Text(item.selectedOptions.map((o) => o.name).join(', '),
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF94A3B8))),
                const SizedBox(height: 4),
                Text(CurrencyUtil.format(item.subtotal / item.quantity),
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF10B981))),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _QtyActionBtn(
                          icon: Icons.remove,
                          onPressed: () =>
                              context.read<CartCubit>().decrement(item),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text('${item.quantity}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 14)),
                        ),
                        _QtyActionBtn(
                          icon: Icons.add,
                          onPressed: () =>
                              context.read<CartCubit>().increment(item),
                          isAdd: true,
                        ),
                      ],
                    ),
                    Text(CurrencyUtil.format(item.subtotal),
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 14)),
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

class _QtyActionBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isAdd;

  const _QtyActionBtn({
    required this.icon,
    required this.onPressed,
    this.isAdd = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isAdd ? const Color(0xFF10B981) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: isAdd ? const Color(0xFF10B981) : const Color(0xFFE2E8F0)),
        ),
        child: Icon(icon, size: 18, color: isAdd ? Colors.white : const Color(0xFF64748B)),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _SummaryRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Color(0xFF64748B))),
          Text(value,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? const Color(0xFF1A1A2E))),
        ],
      ),
    );
  }
}

class _AppliedPromoRow extends StatelessWidget {
  final String promoName;
  const _AppliedPromoRow({required this.promoName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 16),
          const SizedBox(width: 4),
          Expanded(
            child: Text('Promo $promoName digunakan',
                style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF10B981),
                    fontWeight: FontWeight.w600)),
          ),
          GestureDetector(
            onTap: () => context.read<CartCubit>().removePromo(),
            child: const Text('Batal',
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFEF4444),
                    decoration: TextDecoration.underline)),
          ),
        ],
      ),
    );
  }
}
