import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/shift_cubit.dart';
import '../../cubits/auth_cubit.dart';
import '../../cubits/history_cubit.dart';
import '../../data/models/shift.dart';
import '../../utils/app_colors.dart';
import '../../utils/currency_util.dart';

class CloseShiftDialog extends StatefulWidget {
  final ShiftModel shift;
  final VoidCallback? onSuccess;

  const CloseShiftDialog({
    super.key,
    required this.shift,
    this.onSuccess,
  });

  @override
  State<CloseShiftDialog> createState() => _CloseShiftDialogState();
}

class _CloseShiftDialogState extends State<CloseShiftDialog> {
  late final TextEditingController _cashController;
  late final TextEditingController _notesController;
  bool _isClosing = false;

  @override
  void initState() {
    super.initState();
    _cashController = TextEditingController();
    _notesController = TextEditingController(text: widget.shift.notes);
  }

  @override
  void dispose() {
    _cashController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _onCloseShift() async {
    final finalCash = double.tryParse(_cashController.text);
    if (finalCash == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan total kas akhir yang valid')),
      );
      return;
    }

    setState(() => _isClosing = true);

    final authState = context.read<AuthCubit>().state;
    final userId = authState.maybeWhen(
      authenticated: (_, user) => user.id,
      orElse: () => 0,
    );

    try {
      await context.read<ShiftCubit>().closeShift(
            widget.shift.id!,
            userId,
            finalCash,
            _notesController.text,
          );
      
      if (mounted) {
        Navigator.pop(context);
        widget.onSuccess?.call();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isClosing = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menutup shift: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final historyState = context.watch<HistoryCubit>().state;
    
    final userName = authState.maybeWhen(
      authenticated: (_, user) => user.name,
      orElse: () => 'Kasir',
    );

    // Calculate stats for active shift
    final startTime = widget.shift.startTime;
    final shiftSales = historyState.sales.where((s) {
      final saleTime = DateTime.tryParse(s.createdAt);
      if (saleTime == null) return false;
      return saleTime.isAfter(startTime);
    }).toList();

    final totalSales = shiftSales.fold(0.0, (sum, s) => sum + s.grandTotal);
    final totalTransactions = shiftSales.length;
    final expectedCash = widget.shift.cashIn + totalSales;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Container(
        width: 420,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.history_toggle_off,
                  color: AppColors.error,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Tutup Shift',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Summary Box
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFF1F5F9)),
                ),
                child: Column(
                  children: [
                    _buildSummaryRow('Modal Awal', CurrencyUtil.format(widget.shift.cashIn)),
                    const SizedBox(height: 12),
                    _buildSummaryRow(
                      'Total Penjualan', 
                      CurrencyUtil.format(totalSales),
                      valueColor: const Color(0xFF10B981),
                    ),
                    const SizedBox(height: 12),
                    _buildSummaryRow('Total Transaksi', '${totalTransactions}x'),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(height: 1, color: Color(0xFFE2E8F0)),
                    ),
                    _buildSummaryRow(
                      'Ekspektasi Kas', 
                      CurrencyUtil.format(expectedCash),
                      isBold: true,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Input Sections
              _buildInputLabel('Uang di Kasir Sekarang'),
              TextField(
                controller: _cashController,
                decoration: InputDecoration(
                  prefixText: 'Rp ',
                  hintText: '0',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.primary, width: 2),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
                keyboardType: TextInputType.number,
              ),
              
              const SizedBox(height: 20),
              
              _buildInputLabel('Keterangan (opsional)'),
              TextField(
                controller: _notesController,
                decoration: InputDecoration(
                  hintText: 'Tulis keterangan tambahan...',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.primary, width: 2),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
                maxLines: 3,
              ),
              
              const SizedBox(height: 32),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isClosing ? null : () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Batal',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isClosing ? null : _onCloseShift,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEF4444),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: _isClosing
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Tutup Shift',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? valueColor, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF64748B),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? AppColors.textPrimary,
            fontSize: 15,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF334155),
          ),
        ),
      ),
    );
  }
}
