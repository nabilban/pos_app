import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../widgets/pos_header.dart';
import '../widgets/category_bar.dart';
import '../widgets/product_card.dart';
import '../widgets/cart_sidebar.dart';
import '../widgets/settings_drawer.dart';
import '../widgets/payment_modal.dart';

const List<Product> _allProducts = [
  Product(
    id: 'p1',
    name: 'Nasi Goreng',
    price: 25000,
    category: 'Makanan',
    iconLabel: '🍳',
  ),
  Product(
    id: 'p2',
    name: 'Mie Ayam',
    price: 20000,
    category: 'Makanan',
    iconLabel: '🍜',
  ),
  Product(
    id: 'p3',
    name: 'Ayam Bakar',
    price: 35000,
    category: 'Makanan',
    iconLabel: '🍗',
  ),
  Product(
    id: 'p4',
    name: 'Gado-Gado',
    price: 18000,
    category: 'Makanan',
    iconLabel: '🥗',
  ),
  Product(
    id: 'p5',
    name: 'Soto Ayam',
    price: 22000,
    category: 'Makanan',
    iconLabel: '🍲',
  ),
  Product(
    id: 'p6',
    name: 'Nasi Uduk',
    price: 17000,
    category: 'Makanan',
    iconLabel: '🍚',
  ),
  Product(
    id: 'p7',
    name: 'Es Teh Manis',
    price: 5000,
    category: 'Minuman',
    iconLabel: '🧋',
  ),
  Product(
    id: 'p8',
    name: 'Jus Alpukat',
    price: 15000,
    category: 'Minuman',
    iconLabel: '🥤',
  ),
  Product(
    id: 'p9',
    name: 'Kopi Susu',
    price: 18000,
    category: 'Minuman',
    iconLabel: '☕',
  ),
  Product(
    id: 'p10',
    name: 'Es Jeruk',
    price: 8000,
    category: 'Minuman',
    iconLabel: '🍊',
  ),
  Product(
    id: 'p11',
    name: 'Air Mineral',
    price: 4000,
    category: 'Minuman',
    iconLabel: '💧',
  ),
  Product(
    id: 'p12',
    name: 'Keripik Singkong',
    price: 10000,
    category: 'Snack',
    iconLabel: '🍟',
  ),
  Product(
    id: 'p13',
    name: 'Gorengan',
    price: 5000,
    category: 'Snack',
    iconLabel: '🥠',
  ),
  Product(
    id: 'p14',
    name: 'Pisang Goreng',
    price: 8000,
    category: 'Snack',
    iconLabel: '🍌',
  ),
  Product(
    id: 'p15',
    name: 'Tempeh Goreng',
    price: 6000,
    category: 'Snack',
    iconLabel: '🟫',
  ),
  Product(
    id: 'p16',
    name: 'Teh Botol',
    price: 7000,
    category: 'Lainnya',
    iconLabel: '🫖',
  ),
  Product(
    id: 'p17',
    name: 'Rokok',
    price: 30000,
    category: 'Lainnya',
    iconLabel: '🚬',
  ),
  Product(
    id: 'p18',
    name: 'Permen',
    price: 2000,
    category: 'Lainnya',
    iconLabel: '🍬',
  ),
];

const List<String> _categories = [
  'Semua',
  'Makanan',
  'Minuman',
  'Snack',
  'Lainnya',
];

class PosScreen extends StatefulWidget {
  const PosScreen({super.key});

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  String _selectedCategory = 'Semua';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Product> get _filteredProducts {
    if (_selectedCategory == 'Semua') return _allProducts;
    return _allProducts.where((p) => p.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        final cartWidth = isWide
            ? constraints.maxWidth * 0.30
            : constraints.maxWidth;

        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: const Color(0xFFF8FAFC),
          drawer: const SettingsDrawer(),
          body: Column(
            children: [
              PosHeader(
                onSettingsTap: () => _scaffoldKey.currentState?.openDrawer(),
              ),
              CategoryBar(
                categories: _categories,
                selected: _selectedCategory,
                onSelect: (cat) => setState(() => _selectedCategory = cat),
              ),
              Expanded(
                child: isWide
                    ? Row(
                        children: [
                          // Product grid
                          Expanded(child: _buildProductGrid()),
                          // Cart sidebar
                          SizedBox(
                            width: cartWidth,
                            child: CartSidebar(
                              onCheckout: () => showPaymentModal(context),
                            ),
                          ),
                        ],
                      )
                    : _buildProductGrid(),
              ),
              // Mobile: cart is a floating bottom bar
              if (!isWide) _buildMobileCartBar(context),
            ],
          ),
          bottomNavigationBar: null,
        );
      },
    );
  }

  Widget _buildProductGrid() {
    final products = _filteredProducts;
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
          index: _allProducts.indexOf(product),
          onTap: () => context.read<CartProvider>().addProduct(product),
        );
      },
    );
  }

  Widget _buildMobileCartBar(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, _) {
        if (cart.items.isEmpty) return const SizedBox.shrink();
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
                            '${cart.itemCount}',
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
                    '${cart.itemCount} item',
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
