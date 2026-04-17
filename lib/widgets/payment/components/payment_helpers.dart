import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/checkout_cubit.dart';
import '../../../utils/currency_util.dart';

class AmountChip extends StatelessWidget {
  final double amount;
  final TextEditingController cashController;

  const AmountChip({
    super.key,
    required this.amount,
    required this.cashController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        label: Text(CurrencyUtil.format(amount)),
        onPressed: () {
          cashController.text = amount.toInt().toString();
          context.read<CheckoutCubit>().setCashAmount(amount);
        },
        backgroundColor: Colors.white,
        side: const BorderSide(color: Color(0xFFE2E8F0)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

class DropdownSelector extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;

  const DropdownSelector({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value)
              ? value
              : (items.isNotEmpty ? items.first : null),
          isExpanded: true,
          onChanged: onChanged,
          items: items.map((String val) {
            return DropdownMenuItem<String>(value: val, child: Text(val));
          }).toList(),
        ),
      ),
    );
  }
}
