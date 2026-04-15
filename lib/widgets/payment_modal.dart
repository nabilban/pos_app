import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/cart_cubit.dart';
import '../cubits/cart_state.dart';
import '../cubits/connectivity_cubit.dart';
import '../cubits/connectivity_state.dart';
import '../data/models/payment_method.dart';
import '../data/repositories/pos_repository.dart';
import '../data/models/promo.dart';
import '../data/models/price_category.dart';
import '../cubits/checkout_cubit.dart';
import '../cubits/checkout_state.dart';
import '../data/datasource/local/local_cache_store.dart';
import 'receipt_dialog.dart';
import '../utils/app_colors.dart';
import 'payment/components/payment_button.dart';
import 'payment/steps/cart_summary_step.dart';
import 'payment/steps/payment_selection_step.dart';

Future<void> showPaymentModal(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider(
      create: (context) => CheckoutCubit(
        context.read<IPosRepository>(),
        context.read<LocalCacheStore>(),
      ),
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
  List<PriceCategory> _priceCategories = [];
  bool _isCheckingVoucher = false;
  bool _isClosing = false;
  bool _showValidationErrors = false;
  int? _selectedPriceCategoryId;
  int? _selectedPromoId;
  String? _promoWarning;

  @override
  void initState() {
    super.initState();
    _fetchPaymentMethods();
    _fetchPromos();
    _fetchPriceCategories();
  }

  Future<void> _fetchPriceCategories() async {
    try {
      final repo = context.read<IPosRepository>();
      final categories = await repo.getPriceCategories();
      if (mounted) setState(() => _priceCategories = categories);
    } catch (_) {}
  }

  Future<void> _onPriceCategoryChanged(int? categoryId) async {
    setState(() => _selectedPriceCategoryId = categoryId);
    context.read<CheckoutCubit>().setPriceCategoryId(categoryId);

    if (categoryId == null) {
      context.read<CartCubit>().clearPriceCategory();
      return;
    }

    try {
      final repo = context.read<IPosRepository>();
      final products = await repo.getPriceCategoryProducts(categoryId);
      final overrides = <int, double>{
        for (final p in products) p.productId: p.price,
      };
      if (mounted) context.read<CartCubit>().applyPriceCategory(overrides);
    } catch (_) {}
  }

  Future<void> _fetchPromos() async {
    try {
      final repo = context.read<IPosRepository>();
      final promos = await repo.getPromos();
      if (mounted) {
        setState(() {
          _promos = promos.where((p) {
            final s = p.status?.toLowerCase();
            return s == null || s == 'active';
          }).toList();
          final applied = context.read<CartCubit>().state.appliedPromo;
          if (applied != null) {
            _selectedPromoId = applied.promoId;
          }
        });
      }
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

  Future<void> _onPromoChanged(int? promoId) async {
    final cartState = context.read<CartCubit>().state;
    if (promoId == null) {
      context.read<CartCubit>().removePromo();
      setState(() => _selectedPromoId = null);
      return;
    }

    final promo = _promos.firstWhere((p) => p.promoId == promoId);
    
    setState(() => _isCheckingVoucher = true);
    try {
      final repo = context.read<IPosRepository>();
      final result = await repo.checkVoucher(promo.voucherCode ?? promo.name, cartState.items);
      if (mounted) {
        context.read<CartCubit>().applyPromo(result);
        setState(() => _selectedPromoId = promoId);
      }
    } catch (e) {
      if (mounted) {
        _handlePromoError(e);
      }
    } finally {
      if (mounted) setState(() => _isCheckingVoucher = false);
    }
  }

  void _handlePromoError(dynamic e) {
    String message = 'Promo tidak dapat digunakan';
    if (e is DioException) {
      final data = e.response?.data;
      if (data is Map && data.containsKey('message')) {
        message = data['message'];
      } else {
        message = 'Syarat promo tidak terpenuhi untuk keranjang ini';
      }
    }
    setState(() {
      _selectedPromoId = null;
      _promoWarning = message;
    });
    context.read<CartCubit>().removePromo();
  }

  Future<void> _checkVoucher() async {
    final code = _voucherController.text.trim().toUpperCase();
    if (code.isEmpty) return;
    final cartState = context.read<CartCubit>().state;

    setState(() => _isCheckingVoucher = true);
    try {
      final repo = context.read<IPosRepository>();
      final result = await repo.checkVoucher(code, cartState.items);
      if (mounted) {
        bool exists = _promos.any((p) => p.promoId == result.promoId);
        if (!exists) {
          final newPromo = Promo(
            promoId: result.promoId,
            name: result.name,
            promoType: result.promoType,
            appliesTo: 'ALL',
            condition: 'VOUCHER',
            minQty: 0,
            minTotal: 0,
            discountPct: 0,
            maxDiscount: 0,
            cutPrice: 0,
            voucherCode: code,
            status: 'active',
          );
          setState(() => _promos = [..._promos, newPromo]);
        }

        context.read<CartCubit>().applyPromo(result);
        setState(() {
          _selectedPromoId = result.promoId;
          _promoWarning = null;
        });
        _voucherController.clear();
      }
    } catch (e) {
      if (mounted) _handleVoucherError(e);
    } finally {
      if (mounted) setState(() => _isCheckingVoucher = false);
    }
  }

  void _handleVoucherError(dynamic e) {
    String message = 'Voucher gagal diproses';
    if (e is DioException) {
      final data = e.response?.data;
      if (data is Map) {
        message = data['message'] ?? data['error'] ?? message;
      } else if (e.response?.statusCode == 404) {
        message = 'Voucher tidak ditemukan';
      }
    }
    setState(() => _promoWarning = message);
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
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      builder: (context, connectivityState) {
        final isOnline = connectivityState.isOnline;
        return BlocConsumer<CheckoutCubit, CheckoutState>(
          listener: (context, checkoutState) {
            if (checkoutState.success) {
              _isClosing = true;
              Navigator.pop(context);
              showReceiptDialog(
                context,
                checkoutState.selectedMethod,
                buyerName: checkoutState.buyerName,
                invoiceNumber: checkoutState.invoiceNumber,
                isOffline: checkoutState.savedOffline,
              );
              context.read<CartCubit>().clear();
            }
          },
          builder: (context, checkoutState) {
            return BlocConsumer<CartCubit, CartState>(
              listener: (context, cartState) {
                if (cartState.items.isEmpty && !_isClosing) {
                  _isClosing = true;
                  context.read<CartCubit>().clear();
                  Navigator.pop(context);
                }
              },
              builder: (context, cartState) {
                return Stack(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.9,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                      ),
                      child: SafeArea(
                        bottom: true,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildHeader(checkoutState, cartState),
                            const Divider(height: 1),
                            _buildContent(checkoutState, cartState),
                            _buildFooter(checkoutState, cartState, isOnline),
                          ],
                        ),
                      ),
                    ),
                    if (checkoutState.isProcessing || _isCheckingVoucher)
                      _buildLoadingOverlay(),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildHeader(CheckoutState checkoutState, CartState cartState) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
      child: Row(
        children: [
          if (checkoutState.currentStep == 1)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 20),
              onPressed: () {
                setState(() => _showValidationErrors = false);
                context.read<CheckoutCubit>().setStep(0);
              },
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
                Text(
                  checkoutState.currentStep == 0 
                      ? '${cartState.items.length} produk' 
                      : 'Atas nama: ${checkoutState.buyerName}',
                  style: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                ),
              ],
            ),
          ),
          if (checkoutState.currentStep == 0)
            IconButton(
              icon: const Icon(Icons.close_rounded, size: 28),
              onPressed: () => Navigator.pop(context),
              color: AppColors.textMuted,
            ),
        ],
      ),
    );
  }

  Widget _buildContent(CheckoutState checkoutState, CartState cartState) {
    return Flexible(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          children: [
            if (checkoutState.error != null) _buildErrorBanner(checkoutState.error!),
            if (checkoutState.currentStep == 0)
              CartSummaryStep(
                cartState: cartState,
                checkoutState: checkoutState,
                priceCategories: _priceCategories,
                promos: _promos,
                selectedPriceCategoryId: _selectedPriceCategoryId,
                selectedPromoId: _selectedPromoId,
                promoWarning: _promoWarning,
                isCheckingVoucher: _isCheckingVoucher,
                buyerController: _buyerController,
                voucherController: _voucherController,
                onPriceCategoryChanged: _onPriceCategoryChanged,
                onPromoChanged: _onPromoChanged,
                onCheckVoucher: _checkVoucher,
                showValidationErrors: _showValidationErrors,
              )
            else
              PaymentSelectionStep(
                cartState: cartState,
                checkoutState: checkoutState,
                paymentMethods: _paymentMethods,
                cashController: _cashController,
                showValidationErrors: _showValidationErrors,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorBanner(String error) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppColors.error, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              error,
              style: const TextStyle(color: AppColors.error, fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(
    CheckoutState checkoutState,
    CartState cartState,
    bool isOnline,
  ) {
    final isPaymentStep = checkoutState.currentStep == 1;
    final isOfflinePaymentStep = isPaymentStep && !isOnline;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isOfflinePaymentStep)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFF4C542), width: 1.2),
              ),
              child: const Text(
                'Anda offline. Transaksi akan disimpan dan disinkronkan otomatis nanti.',
                style: TextStyle(
                  color: Color(0xFFB45309),
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          PrimaryButton(
            label: checkoutState.isProcessing
                ? 'Memproses...'
                : (checkoutState.currentStep == 0
                      ? 'Lanjut Pembayaran'
                      : (isOnline ? 'Proses Transaksi' : 'Simpan Offline')),
            icon: checkoutState.currentStep == 0
                ? Icons.arrow_forward
                : (isOnline ? Icons.check : Icons.save),
            onPressed: checkoutState.isProcessing
                ? null
                : () {
                    final isValid = _validateCurrentStep(
                      checkoutState,
                      cartState,
                    );
                    if (!isValid) {
                      setState(() => _showValidationErrors = true);
                      return;
                    }

                    setState(() => _showValidationErrors = false);
                    if (checkoutState.currentStep == 0) {
                      context.read<CheckoutCubit>().setStep(1);
                    } else {
                      context.read<CheckoutCubit>().processCheckout(
                        cartState,
                        isOnline: isOnline,
                      );
                    }
                  },
          ),
        ],
      ),
    );
  }

  bool _validateCurrentStep(CheckoutState checkoutState, CartState cartState) {
    if (checkoutState.currentStep == 0) {
      return checkoutState.buyerName.trim().isNotEmpty;
    }

    final isCash =
        ['cash', 'tunai'].contains(checkoutState.selectedMethod.toLowerCase());
    if (isCash) {
      return checkoutState.cashAmount >= cartState.total;
    }
    return true;
  }

  Widget _buildLoadingOverlay() {
    return Positioned.fill(
      child: AbsorbPointer(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.5),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: const Center(
            child: CircularProgressIndicator(color: AppColors.success),
          ),
        ),
      ),
    );
  }
}
