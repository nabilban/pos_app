import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/pos_cubit.dart';
import '../cubits/pos_state.dart';
import '../data/models/brand.dart';
import '../utils/app_colors.dart';

class SearchFilterBar extends StatelessWidget {
  const SearchFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PosCubit, PosState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: AppColors.surface,
          child: Row(
            children: [
              // Search Input (takes 2 parts)
              Expanded(
                flex: 2,
                child: TextField(
                  onChanged: (value) =>
                      context.read<PosCubit>().setSearchQuery(value),
                  decoration: _buildInputDecoration(
                    hintText: 'Cari nama / kode produk...',
                    prefixIcon: Icons.search,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Brand Dropdown (takes 1 part)
              Expanded(
                flex: 1,
                child: _buildDropdown<Brand>(
                  hint: 'Brand',
                  initialValue: state.selectedBrand,
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('Semua'),
                    ),
                    ...state.brands.map(
                      (brand) => DropdownMenuItem(
                        value: brand,
                        child: Text(brand.name),
                      ),
                    ),
                  ],
                  onChanged: (value) =>
                      context.read<PosCubit>().setBrand(value),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: const Icon(Icons.search, color: AppColors.textMuted, size: 20),
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.success),
      ),
      filled: true,
      fillColor: AppColors.surface,
      hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
    );
  }

  Widget _buildDropdown<T>({
    required String hint,
    required T? initialValue,
    required List<DropdownMenuItem<T?>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonFormField<T?>(
      isExpanded: true,
      initialValue: initialValue,
      items: items.map((item) {
        return DropdownMenuItem<T?>(
          value: item.value,
          child: DefaultTextStyle(
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 13,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
            child: item.child,
          ),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.success),
        ),
        filled: true,
        fillColor: AppColors.surface,
      ),
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: AppColors.textSecondary,
        size: 20,
      ),
      hint: Text(
        hint,
        style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
      ),
    );
  }
}
