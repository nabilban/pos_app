import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/settings_cubit.dart';
import '../cubits/settings_state.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settings) {
        final cubit = context.read<SettingsCubit>();
        return Drawer(
          width: 280,
          child: SafeArea(
            child: Column(
              children: [
                // Drawer header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 20, 16, 20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Pengaturan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white70,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(0),
                    children: [
                      // Promo section
                      _SectionHeader(
                        title: 'Promo',
                        icon: Icons.local_offer_outlined,
                      ),
                      _ToggleItem(
                        label: 'Diskon 10%',
                        subtitle: 'Potongan harga 10% untuk semua item',
                        value: settings.diskon10,
                        onChanged: cubit.toggleDiskon10,
                        color: const Color(0xFF22C55E),
                      ),
                      _ToggleItem(
                        label: 'Cashback Rp 50.000',
                        subtitle: 'Cashback untuk total belanja > Rp 200.000',
                        value: settings.cashback50,
                        onChanged: cubit.toggleCashback50,
                        color: const Color(0xFFF97316),
                      ),
                      _ToggleItem(
                        label: 'Gratis Minuman',
                        subtitle: 'Gratis 1 minuman untuk setiap pembelian',
                        value: settings.gratisMinuman,
                        onChanged: cubit.toggleGratisMinuman,
                        color: const Color(0xFF6366F1),
                      ),

                      const Divider(height: 8, color: Color(0xFFF1F5F9)),

                      // Printer section
                      _SectionHeader(
                        title: 'Printer',
                        icon: Icons.print_outlined,
                      ),
                      _ToggleItem(
                        label: 'Cetak Struk Otomatis',
                        subtitle: 'Struk tercetak otomatis setelah transaksi',
                        value: settings.cetakStruk,
                        onChanged: cubit.toggleCetakStruk,
                        color: const Color(0xFF2563EB),
                      ),
                      _ToggleItem(
                        label: 'Cetak Nama Kasir',
                        subtitle: 'Tampilkan nama kasir pada struk',
                        value: settings.cetakKasir,
                        onChanged: cubit.toggleCetakKasir,
                        color: const Color(0xFF2563EB),
                      ),
                      _ToggleItem(
                        label: 'Cetak Waktu Transaksi',
                        subtitle: 'Tampilkan waktu pada struk',
                        value: settings.cetakWaktu,
                        onChanged: cubit.toggleCetakWaktu,
                        color: const Color(0xFF2563EB),
                      ),
                    ],
                  ),
                ),

                // Logout button
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.logout, size: 18),
                      label: const Text(
                        'Logout',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEF4444),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                    ),
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

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: const Color(0xFF64748B)),
          const SizedBox(width: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF64748B),
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleItem extends StatelessWidget {
  final String label;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color color;

  const _ToggleItem({
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: SwitchListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 4),
        value: value,
        onChanged: onChanged,
        activeThumbColor: color,
        title: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF1A1A2E),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
        ),
      ),
    );
  }
}
