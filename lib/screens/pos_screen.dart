import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product.dart';
import '../cubits/cart_cubit.dart';
import '../cubits/cart_state.dart';
import '../cubits/pos_cubit.dart';
import '../cubits/pos_state.dart';
import '../repositories/pos_repository.dart';
import '../widgets/pos_header.dart';
import '../widgets/category_bar.dart';
import '../widgets/product_card.dart';
import '../widgets/cart_sidebar.dart';
import '../widgets/settings_drawer.dart';
import '../widgets/payment_modal.dart';

class PosScreen extends StatelessWidget {
  const PosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocProvider(
      create: (context) =>
          PosCubit(RepositoryProvider.of<PosRepository>(context)),
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

              final List<Product> filteredProducts =
                  posState.selectedCategory == 'Semua'
                  ? posState.products
                  : posState.products
                        .where((p) => p.category == posState.selectedCategory)
                        .toList();

              return Scaffold(
                key: scaffoldKey,
                backgroundColor: const Color(0xFFF8FAFC),
                drawer: const SettingsDrawer(),
                body: SafeArea(
                  child: Column(
                    children: [
                      PosHeader(
                        onSettingsTap: () =>
                            scaffoldKey.currentState?.openDrawer(),
                      ),
                      CategoryBar(
                        categories: posState.categories,
                        selected: posState.selectedCategory,
                        onSelect: (cat) =>
                            context.read<PosCubit>().setCategory(cat),
                      ),
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
                                      onCheckout: () =>
                                          showPaymentModal(context),
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
                ),
                bottomNavigationBar: null,
              );
            },
          );
        },
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
          onTap: () => context.read<CartCubit>().addProduct(product),
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
                      color: Color(0xFF2563EB),
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
                  onPressed: () => showPaymentModal(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
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
