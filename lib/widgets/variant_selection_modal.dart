import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/product.dart';
import '../data/models/variant.dart';
import '../data/models/cart_item.dart';
import '../cubits/cart_cubit.dart';
import '../utils/currency_util.dart';

class VariantSelectionModal extends StatefulWidget {
  final Product product;
  final List<VariantOption>? initialOptions;
  final CartItem? cartItem; // Optional: only for edit mode

  const VariantSelectionModal({
    super.key,
    required this.product,
    this.initialOptions,
    this.cartItem,
  });

  static Future<void> show(
    BuildContext context,
    Product product, {
    List<VariantOption>? initialOptions,
    CartItem? cartItem,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => VariantSelectionModal(
        product: product,
        initialOptions: initialOptions,
        cartItem: cartItem,
      ),
    );
  }

  @override
  State<VariantSelectionModal> createState() => _VariantSelectionModalState();
}

class _VariantSelectionModalState extends State<VariantSelectionModal> {
  final Map<int, List<VariantOption>> _selectedOptions = {};

  @override
  void initState() {
    super.initState();
    // Initialize variant slots
    for (var variant in widget.product.variants) {
      _selectedOptions[variant.id] = [];
    }

    // Pre-fill if editing
    if (widget.initialOptions != null) {
      for (var option in widget.initialOptions!) {
        // Find which variant category this option belongs to
        for (var v in widget.product.variants) {
          if (v.options.any((o) => o.id == option.id)) {
            if (!_selectedOptions[v.id]!.any((o) => o.id == option.id)) {
              _selectedOptions[v.id]?.add(option);
            }
            break;
          }
        }
      }
    }
  }

  double get _totalPrice {
    double total = widget.product.price;
    for (var options in _selectedOptions.values) {
      for (var option in options) {
        total += option.additionalPrice;
      }
    }
    return total;
  }

  bool _isSelectionValid() {
    for (var variant in widget.product.variants) {
      final selectedCount = _selectedOptions[variant.id]?.length ?? 0;
      if (selectedCount < variant.minSelect) return false;
    }
    return true;
  }

  void _toggleOption(Variant variant, VariantOption option) {
    setState(() {
      final selected = _selectedOptions[variant.id] ?? [];
      final isSelected = selected.any((o) => o.id == option.id);

      if (variant.maxSelect == 1) {
        if (isSelected) {
          if (variant.minSelect == 0) {
            _selectedOptions[variant.id] = [];
          }
        } else {
          _selectedOptions[variant.id] = [option];
        }
      } else {
        if (isSelected) {
          _selectedOptions[variant.id] =
              selected.where((o) => o.id != option.id).toList();
        } else {
          if (selected.length < variant.maxSelect) {
            _selectedOptions[variant.id] = [...selected, option];
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.cartItem != null;
    final bottomSafeInset = MediaQuery.viewPaddingOf(context).bottom;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle/Indicator
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        CurrencyUtil.format(widget.product.price),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF059669),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.close, size: 20, color: Color(0xFF64748B)),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Variants List
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: widget.product.variants.length,
              itemBuilder: (context, index) {
                final variant = widget.product.variants[index];
                return _buildVariantSection(variant);
              },
            ),
          ),

          // Footer / Action
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomSafeInset),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Harga',
                      style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                    ),
                    Text(
                      CurrencyUtil.format(_totalPrice),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isSelectionValid()
                        ? () {
                            final allSelected = _selectedOptions.values
                                .expand((e) => e)
                                .toList();
                            if (isEdit) {
                              context.read<CartCubit>().updateItemOptions(
                                    widget.cartItem!,
                                    allSelected,
                                  );
                            } else {
                              context.read<CartCubit>().addProduct(
                                    widget.product,
                                    selectedOptions: allSelected,
                                  );
                            }
                            Navigator.pop(context);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF059669),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: const Color(0xFFE2E8F0),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      isEdit ? 'Simpan Perubahan' : 'Tambah ke Keranjang',
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVariantSection(Variant variant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: [
              Text(
                variant.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(width: 8),
              if (variant.minSelect > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Wajib',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFEF4444),
                    ),
                  ),
                ),
              const Spacer(),
              Text(
                variant.maxSelect == 1 ? 'Pilih 1' : 'Pilih maks ${variant.maxSelect}',
                style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
              ),
            ],
          ),
        ),
        ...variant.options.map((option) {
          final isSelected = (_selectedOptions[variant.id] ?? [])
              .any((o) => o.id == option.id);
          return InkWell(
            onTap: () => _toggleOption(variant, option),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          option.name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            color: isSelected ? const Color(0xFF059669) : const Color(0xFF475569),
                          ),
                        ),
                        if (option.additionalPrice > 0)
                          Text(
                            '+ ${CurrencyUtil.format(option.additionalPrice)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF059669),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ],
                    ),
                  ),
                  _buildSelector(variant, isSelected),
                ],
              ),
            ),
          );
        }),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Divider(height: 1, color: Color(0xFFF1F5F9)),
        ),
      ],
    );
  }

  Widget _buildSelector(Variant variant, bool isSelected) {
    if (variant.maxSelect == 1) {
      return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? const Color(0xFF059669) : const Color(0xFFCBD5E1),
            width: isSelected ? 6 : 1.5,
          ),
        ),
      );
    } else {
      return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelected ? const Color(0xFF059669) : const Color(0xFFCBD5E1),
            width: 1.5,
          ),
          color: isSelected ? const Color(0xFF059669) : Colors.transparent,
        ),
        child: isSelected
            ? const Icon(Icons.check, size: 14, color: Colors.white)
            : null,
      );
    }
  }
}
