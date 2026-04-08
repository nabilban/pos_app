import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/cart_state.dart';
import '../../../cubits/checkout_cubit.dart';
import '../../../cubits/checkout_state.dart';
import '../../../data/models/price_category.dart';
import '../../../data/models/promo.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/currency_util.dart';
import '../components/applied_promo_row.dart';
import '../components/cart_item_row.dart';
import '../components/payment_labels.dart';
import '../components/summary_row.dart';

class CartSummaryStep extends StatelessWidget {
  final CartState cartState;
  final CheckoutState checkoutState;
  final List<PriceCategory> priceCategories;
  final List<Promo> promos;
  final int? selectedPriceCategoryId;
  final int? selectedPromoId;
  final String? promoWarning;
  final bool isCheckingVoucher;
  final TextEditingController buyerController;
  final TextEditingController voucherController;
  final Function(int?) onPriceCategoryChanged;
  final Function(int?) onPromoChanged;
  final VoidCallback onCheckVoucher;

  const CartSummaryStep({
    super.key,
    required this.cartState,
    required this.checkoutState,
    required this.priceCategories,
    required this.promos,
    this.selectedPriceCategoryId,
    this.selectedPromoId,
    this.promoWarning,
    required this.isCheckingVoucher,
    required this.buyerController,
    required this.voucherController,
    required this.onPriceCategoryChanged,
    required this.onPromoChanged,
    required this.onCheckVoucher,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LabelWithAsterisk(label: 'Nama Pembeli'),
        const SizedBox(height: 8),
        TextField(
          controller: buyerController,
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
            return CartItemRow(item: item, priceOverrides: cartState.priceOverrides);
          },
        ),
        const SizedBox(height: 24),

        // Price Level Dropdown
        const SectionLabel(icon: Icons.monetization_on, label: 'Tingkat Harga'),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int?>(
              value: selectedPriceCategoryId,
              isExpanded: true,
              hint: const Text('Normal (Harga Default)'),
              items: [
                const DropdownMenuItem<int?>(
                  value: null,
                  child: Text('Normal (Harga Default)', style: TextStyle(color: Color(0xFF64748B))),
                ),
                ...priceCategories.map((cat) => DropdownMenuItem<int?>(
                  value: cat.id,
                  child: Text(cat.name),
                )),
              ],
              onChanged: onPriceCategoryChanged,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Promos Dropdown
        const SectionLabel(icon: Icons.sell, label: 'Pilih Promo'),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int?>(
              value: selectedPromoId,
              isExpanded: true,
              hint: const Text('Pilih promo yang tersedia'),
              items: [
                const DropdownMenuItem<int?>(
                  value: null,
                  child: Text('Tanpa Promo', style: TextStyle(color: AppColors.textSecondary)),
                ),
                ...promos.map((p) => DropdownMenuItem<int?>(
                  value: p.promoId,
                  child: Text(p.name),
                )),
              ],
              onChanged: onPromoChanged,
            ),
          ),
        ),
        if (promoWarning != null) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Row(
              children: [
                const Icon(Icons.info_outline, size: 14, color: AppColors.error),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    promoWarning!,
                    style: const TextStyle(fontSize: 12, color: AppColors.error),
                  ),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 20),

        // Voucher Input
        const SectionLabel(icon: Icons.confirmation_number, label: 'Kode Voucher'),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: voucherController,
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
                  onPressed: isCheckingVoucher ? null : onCheckVoucher,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
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
          AppliedPromoRow(promoName: cartState.appliedPromo!.name),
        ],
        const SizedBox(height: 24),

        // Summary
        SummaryRow(label: 'Subtotal', value: CurrencyUtil.format(cartState.subtotal)),
        if (cartState.discount > 0)
          SummaryRow(
            label: 'Diskon',
            value: '-${CurrencyUtil.format(cartState.discount)}',
            valueColor: AppColors.error,
          ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            Text(
              CurrencyUtil.format(cartState.total),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.success,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
