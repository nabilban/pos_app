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
import '../cubits/checkout_cubit.dart';
import '../cubits/checkout_state.dart';
import 'variant_selection_modal.dart';
import 'receipt_dialog.dart';

Future<void> showPaymentModal(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider(
      create: (context) => CheckoutCubit(context.read<IPosRepository>()),
      child: const _PaymentSheet(),
    ),
  );
}

class _PaymentSheet extends StatefulWidget {
  const _PaymentSheet();

  @override
  State<_PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<_PaymentSheet> {
  final _cashController = TextEditingController();
  final _voucherController = TextEditingController();
  final _buyerController = TextEditingController();
  
  List<PaymentMethod> _paymentMethods = [];
  List<Promo> _promos = [];
  bool _isCheckingVoucher = false;
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
            context.read<CheckoutCubit>().setPaymentMethod(_paymentMethods.first.name);
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
    return BlocConsumer<CheckoutCubit, CheckoutState>(
      listener: (context, checkoutState) {
        if (checkoutState.success) {
          Navigator.pop(context);
          showReceiptDialog(
            context,
            checkoutState.selectedMethod,
            buyerName: checkoutState.buyerName,
            invoiceNumber: checkoutState.invoiceNumber,
          );
          context.read<CartCubit>().clear();
        }
        if (checkoutState.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(checkoutState.error!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, checkoutState) {
        return BlocBuilder<CartCubit, CartState>(
          builder: (context, cartState) {
            return Stack(
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.9,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
                          child: Row(
                            children: [
                              if (checkoutState.currentStep == 1)
                                IconButton(
                                  icon: const Icon(Icons.arrow_back_ios, size: 20),
                                  onPressed: () => context.read<CheckoutCubit>().setStep(0),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              if (checkoutState.currentStep == 1) const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      checkoutState.currentStep == 0 ? 'Keranjang' : 'Pembayaran',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF1A1A2E),
                                      ),
                                    ),
                                    if (checkoutState.currentStep == 0)
                                      Text(
                                        '${cartState.items.length} produk',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF94A3B8),
                                        ),
                                      ),
                                    if (checkoutState.currentStep == 1)
                                      Text(
                                        'Atas nama: ${checkoutState.buyerName}',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF94A3B8),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (checkoutState.currentStep == 0)
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
                                if (checkoutState.currentStep == 0) ...[
                                  _buildCartStep(cartState, checkoutState),
                                ] else ...[
                                  _buildPaymentStep(cartState, checkoutState),
                                ],
                              ],
                            ),
                          ),
                        ),

                        // Footer Button
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                          child: _PrimaryButton(
                            label: checkoutState.isProcessing
                                ? 'Memproses...'
                                : (checkoutState.currentStep == 0 ? 'Lanjut Pembayaran' : 'Proses Transaksi'),
                            icon: checkoutState.currentStep == 0 ? Icons.arrow_forward : Icons.check,
                            onPressed: (checkoutState.isProcessing ||
                                    (checkoutState.currentStep == 0 && checkoutState.buyerName.trim().isEmpty) ||
                                    (checkoutState.currentStep == 1 &&
                                        (['cash', 'tunai'].contains(checkoutState.selectedMethod.toLowerCase())) &&
                                        checkoutState.cashAmount < cartState.total))
                                ? null
                                : (checkoutState.currentStep == 0
                                    ? () => context.read<CheckoutCubit>().setStep(1)
                                    : () => context.read<CheckoutCubit>().processCheckout(cartState)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (checkoutState.isProcessing)
                  Positioned.fill(
                    child: AbsorbPointer(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.5),
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(color: Color(0xFF2563EB)),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildCartStep(CartState cartState, CheckoutState checkoutState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _LabelWithAsterisk(label: 'Nama Pembeli'),
        const SizedBox(height: 8),
        TextField(
          controller: _buyerController,
          onChanged: (val) => context.read<CheckoutCubit>().setBuyerName(val),
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
          itemCount: cartState.items.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final item = cartState.items[index];
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
                  onPressed: _isCheckingVoucher ? null : () => _checkVoucher(cartState),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
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
        if (cartState.appliedPromo != null) ...[
          const SizedBox(height: 8),
          _AppliedPromoRow(promoName: cartState.appliedPromo!.name),
        ],
        const SizedBox(height: 24),

        // Summary
        _SummaryRow(label: 'Subtotal', value: CurrencyUtil.format(cartState.subtotal)),
        if (cartState.discount > 0)
          _SummaryRow(
            label: 'Diskon',
            value: '-${CurrencyUtil.format(cartState.discount)}',
            valueColor: const Color(0xFFEF4444),
          ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            Text(
              CurrencyUtil.format(cartState.total),
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2563EB)),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildPaymentStep(CartState cartState, CheckoutState checkoutState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Total Tagihan Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              const Text('Total Tagihan',
                  style: TextStyle(fontSize: 14, color: Color(0xFF2563EB))),
              const SizedBox(height: 8),
              Text(
                CurrencyUtil.format(cartState.total),
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
          value: checkoutState.selectedMethod,
          items: _paymentMethods.map((e) => e.name).toList(),
          onChanged: (val) => context.read<CheckoutCubit>().setPaymentMethod(val!),
        ),
        const SizedBox(height: 16),

        if (['cash', 'tunai'].contains(checkoutState.selectedMethod.toLowerCase())) ...[
          const Text('Nominal Dibayar',
              style: TextStyle(fontSize: 14, color: Color(0xFF64748B))),
          const SizedBox(height: 8),
          TextField(
            controller: _cashController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixText: 'Rp ',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF2563EB), width: 2),
              ),
            ),
            onChanged: (val) {
              final amount = double.tryParse(val.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
              context.read<CheckoutCubit>().setCashAmount(amount);
            },
          ),
          const SizedBox(height: 12),

          // Quick amount chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildAmountChip(cartState.total),
                _buildAmountChip(50000),
                _buildAmountChip(100000),
                _buildAmountChip(150000),
              ],
            ),
          ),
        ],
        const SizedBox(height: 24),

        // Split Payment Button UI
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE2E8F0), style: BorderStyle.none),
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
        _SummaryRow(
          label: 'Total Dibayar', 
          value: CurrencyUtil.format(checkoutState.selectedMethod == 'Tunai' ? checkoutState.cashAmount : cartState.total)
        ),
        if (checkoutState.selectedMethod == 'Tunai') ...[
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Kembalian',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              Text(
                CurrencyUtil.format(_getChange(cartState.total, checkoutState.cashAmount)),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2563EB)),
              ),
            ],
          ),
        ],
      ],
    );
  }

  double _getChange(double total, double paid) {
    return paid > total ? paid - total : 0;
  }

  Widget _buildAmountChip(double amount) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        label: Text(CurrencyUtil.format(amount)),
        onPressed: () {
          _cashController.text = amount.toInt().toString();
          context.read<CheckoutCubit>().setCashAmount(amount);
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

class _PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  const _PrimaryButton({
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
          backgroundColor: const Color(0xFF2563EB),
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
              color: Colors.black.withValues(alpha: 0.02),
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
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined,
                              color: Color(0xFF2563EB), size: 20),
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
                          icon: const Icon(Icons.delete_outline,
                              color: Color(0xFFEF4444), size: 20),
                          onPressed: () => context.read<CartCubit>().remove(item),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
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
                        color: Color(0xFF2563EB))),
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
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isAdd ? const Color(0xFF2563EB) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: isAdd ? null : Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Icon(icon,
            size: 16, color: isAdd ? Colors.white : const Color(0xFF64748B)),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 14, color: Color(0xFF64748B))),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: valueColor ?? const Color(0xFF1A1A2E),
            ),
          ),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFBBF7D0)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_rounded,
              color: Color(0xFF2563EB), size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Promo: $promoName',
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF166534)),
            ),
          ),
          GestureDetector(
            onTap: () => context.read<CartCubit>().removePromo(),
            child: const Icon(Icons.close_rounded,
                color: Color(0xFF166534), size: 16),
          ),
        ],
      ),
    );
  }
}
