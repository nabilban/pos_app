import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/pos_cubit.dart';
import '../cubits/pos_state.dart';
import '../data/models/category.dart';
import '../data/models/brand.dart';

class SearchFilterBar extends StatelessWidget {
  const SearchFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PosCubit, PosState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 600;

            if (isNarrow) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.white,
                child: Column(
                  children: [
                    // Search Input (Full width on mobile)
                    TextField(
                      onChanged: (value) =>
                          context.read<PosCubit>().setSearchQuery(value),
                      decoration: _buildInputDecoration(
                        hintText: 'Cari nama / kode produk...',
                        prefixIcon: Icons.search,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        // Category Dropdown
                        Expanded(
                          child: _buildDropdown<Category>(
                            hint: 'Kategori',
                            value: state.selectedCategory,
                            items: [
                              const DropdownMenuItem(
                                value: null,
                                child: Text('Semua Kategori'),
                              ),
                              ...state.categories.map((cat) => DropdownMenuItem(
                                    value: cat,
                                    child: Text(cat.name),
                                  )),
                            ],
                            onChanged: (value) =>
                                context.read<PosCubit>().setCategory(value),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Brand Dropdown
                        Expanded(
                          child: _buildDropdown<Brand>(
                            hint: 'Brand',
                            value: state.selectedBrand,
                            items: [
                              const DropdownMenuItem(
                                value: null,
                                child: Text('Semua Brand'),
                              ),
                              ...state.brands.map((brand) => DropdownMenuItem(
                                    value: brand,
                                    child: Text(brand.name),
                                  )),
                            ],
                            onChanged: (value) =>
                                context.read<PosCubit>().setBrand(value),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  // Search Input
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
                  const SizedBox(width: 12),

                  // Category Dropdown
                  Expanded(
                    flex: 1,
                    child: _buildDropdown<Category>(
                      hint: 'Semua Kategori',
                      value: state.selectedCategory,
                      items: [
                        const DropdownMenuItem(
                          value: null,
                          child: Text('Semua Kategori'),
                        ),
                        ...state.categories.map((cat) => DropdownMenuItem(
                              value: cat,
                              child: Text(cat.name),
                            )),
                      ],
                      onChanged: (value) =>
                          context.read<PosCubit>().setCategory(value),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Brand Dropdown
                  Expanded(
                    flex: 1,
                    child: _buildDropdown<Brand>(
                      hint: 'Semua Brand',
                      value: state.selectedBrand,
                      items: [
                        const DropdownMenuItem(
                          value: null,
                          child: Text('Semua Brand'),
                        ),
                        ...state.brands.map((brand) => DropdownMenuItem(
                              value: brand,
                              child: Text(brand.name),
                            )),
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
      },
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(prefixIcon, color: const Color(0xFF94A3B8)),
      contentPadding: const EdgeInsets.symmetric(vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF2563EB)),
      ),
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
    );
  }

  Widget _buildDropdown<T>({
    required String hint,
    required T? value,
    required List<DropdownMenuItem<T?>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonFormField<T?>(
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2563EB)),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      style: const TextStyle(
        color: Color(0xFF1E293B),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF64748B)),
      hint: Text(hint, style: const TextStyle(fontSize: 14)),
    );
  }
}
