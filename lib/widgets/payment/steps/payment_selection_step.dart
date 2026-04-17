import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/cart_state.dart';
import '../../../cubits/checkout_cubit.dart';
import '../../../cubits/checkout_state.dart';
import '../../../data/models/payment_method.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/currency_util.dart';
import '../components/payment_helpers.dart';
import '../components/summary_row.dart';

class PaymentSelectionStep extends StatelessWidget {
  final CartState cartState;
  final CheckoutState checkoutState;
  final List<PaymentMethod> paymentMethods;
  final TextEditingController cashController;
  final bool showValidationErrors;
  final bool isOnline;

  const PaymentSelectionStep({
    super.key,
    required this.cartState,
    required this.checkoutState,
    required this.paymentMethods,
    required this.cashController,
    required this.showValidationErrors,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    final availableMethods = isOnline
        ? paymentMethods
        : paymentMethods
              .where((method) => _isCashMethod(method.name))
              .toList(growable: false);
    final hasCashMethod = availableMethods.isNotEmpty;
    final isCashSelected =
        _isCashMethod(checkoutState.selectedMethod) ||
        (!isOnline && hasCashMethod);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Total Tagihan Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            color: const Color(0xFFECFDF5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              const Text(
                'Total Tagihan',
                style: TextStyle(fontSize: 14, color: AppColors.success),
              ),
              const SizedBox(height: 8),
              Text(
                CurrencyUtil.format(cartState.total),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF065F46),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        const Text(
          'Metode Pembayaran',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        if (!isOnline)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E8),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFF4C542)),
            ),
            child: Text(
              hasCashMethod
                  ? 'Mode offline hanya mendukung pembayaran Cash/Tunai.'
                  : 'Mode offline membutuhkan metode Cash/Tunai dari data lokal.',
              style: const TextStyle(
                color: Color(0xFFB45309),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        DropdownSelector(
          value: checkoutState.selectedMethod,
          items: availableMethods.map((e) => e.name).toList(),
          onChanged: isOnline
              ? (val) {
                  if (val == null) return;
                  context.read<CheckoutCubit>().setPaymentMethod(val);
                }
              : null,
        ),
        const SizedBox(height: 16),

        if (isCashSelected) ...[
          const Text(
            'Nominal Dibayar',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: cashController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixText: 'Rp ',
              errorText:
                  showValidationErrors &&
                      checkoutState.cashAmount < cartState.total
                  ? 'Nominal dibayar wajib diisi dan tidak boleh kurang dari total'
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.success,
                  width: 2,
                ),
              ),
            ),
            onChanged: (val) {
              final amount =
                  double.tryParse(val.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
              context.read<CheckoutCubit>().setCashAmount(amount);
            },
          ),
          const SizedBox(height: 12),

          // Quick amount chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                AmountChip(
                  amount: cartState.total,
                  cashController: cashController,
                ),
                AmountChip(amount: 50000, cashController: cashController),
                AmountChip(amount: 100000, cashController: cashController),
                AmountChip(amount: 150000, cashController: cashController),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Kembalian inline
          if (checkoutState.cashAmount > cartState.total) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFECFDF5),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF6EE7B7)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.swap_horiz_rounded,
                        size: 16,
                        color: Color(0xFF065F46),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Kembalian',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF065F46),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    CurrencyUtil.format(
                      checkoutState.cashAmount - cartState.total,
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF065F46),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
        const SizedBox(height: 24),

        // Summary Change
        SummaryRow(
          label: 'Total Dibayar',
          value: CurrencyUtil.format(
            isCashSelected ? checkoutState.cashAmount : cartState.total,
          ),
        ),
        if (isCashSelected) ...[
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Kembalian',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Text(
                CurrencyUtil.format(
                  _getChange(cartState.total, checkoutState.cashAmount),
                ),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.success,
                ),
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

  bool _isCashMethod(String methodName) {
    final normalized = methodName.trim().toLowerCase();
    return normalized == 'cash' || normalized == 'tunai';
  }
}
