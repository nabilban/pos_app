import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/product.dart';
import '../cubits/cart_cubit.dart';
import '../cubits/cart_state.dart';
import '../cubits/pos_cubit.dart';
import '../cubits/pos_state.dart';
import '../cubits/connectivity_cubit.dart';
import '../cubits/connectivity_state.dart';
import '../data/repositories/pos_repository.dart';

import '../widgets/category_bar.dart';
import '../widgets/product_card.dart';
import '../widgets/cart_sidebar.dart';
import '../widgets/payment_modal.dart';
import '../widgets/search_filter_bar.dart';
import '../widgets/variant_selection_modal.dart';
import '../widgets/no_internet_banner.dart';

class PosScreen extends StatefulWidget {
  const PosScreen({super.key});

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  bool _isModalShowing = false;

  void _showCheckout() async {
    if (_isModalShowing) return;
    setState(() => _isModalShowing = true);
    await showPaymentModal(context);
    if (mounted) setState(() => _isModalShowing = false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PosCubit(RepositoryProvider.of<IPosRepository>(context)),
      child: BlocListener<ConnectivityCubit, ConnectivityState>(
        listenWhen: (previous, current) =>
            previous.isOnline != current.isOnline && current.isOnline,
        listener: (context, _) => context.read<PosCubit>().loadData(),
        child: BlocBuilder<PosCubit, PosState>(
          builder: (context, posState) {
            if (posState.isLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 600;
                final cartWidth = isWide
                    ? constraints.maxWidth * 0.30
                    : constraints.maxWidth;

                final List<Product> filteredProducts = context
                    .read<PosCubit>()
                    .filteredProducts;

                return ColoredBox(
                  color: const Color(0xFFF8FAFC),
                  child: Column(
                    children: [
                      const NoInternetBanner(
                        title: 'Sedang Offline',
                        message:
                            'Transaksi tetap bisa diproses dan akan disinkronisasi otomatis saat koneksi pulih.',
                        showPendingSales: true,
                      ),
                      CategoryBar(
                        categories: posState.categories,
                        selected: posState.selectedCategory,
                        onSelect: (cat) =>
                            context.read<PosCubit>().setCategory(cat),
                      ),
                      const SearchFilterBar(),
                      Expanded(
                        child: isWide
                            ? Row(
                                children: [
                                  // Product grid
                                  Expanded(
                                    child: _buildProductGrid(
                                      filteredProducts,
                                      posState.products,
                                    ),
                                  ),
                                  // Cart sidebar
                                  SizedBox(
                                    width: cartWidth,
                                    child: CartSidebar(
                                      onCheckout: _showCheckout,
                                    ),
                                  ),
                                ],
                              )
                            : _buildProductGrid(
                                filteredProducts,
                                posState.products,
                              ),
                      ),
                      // Mobile: cart is a floating bottom bar
                      if (!isWide) _buildMobileCartBar(context),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductGrid(List<Product> products, List<Product> allProducts) {
    if (products.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 56, color: Color(0xFFCBD5E1)),
            SizedBox(height: 12),
            Text(
              'Tidak ada produk',
              style: TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 180,
        childAspectRatio: 0.72,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          product: product,
          index: allProducts.indexOf(product),
          onTap: () {
            if (product.variants.isNotEmpty) {
              VariantSelectionModal.show(context, product);
            } else {
              context.read<CartCubit>().addProduct(product);
            }
          },
        );
      },
    );
  }

  Widget _buildMobileCartBar(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state.items.isEmpty) return const SizedBox.shrink();
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 8,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                Stack(
                  children: [
                    const Icon(
                      Icons.shopping_cart,
                      color: Color(0xFF059669),
                      size: 28,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEF4444),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${state.itemCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${state.itemCount} item',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _showCheckout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF059669),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Checkout',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
