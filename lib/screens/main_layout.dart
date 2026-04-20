import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/pos_header.dart';
import '../widgets/pos_status_actions.dart';
import 'pos_screen.dart';
import 'history_screen.dart';
import 'shift_screen.dart';
import 'settings_screen.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/auth_state.dart';
import '../utils/app_colors.dart';
import '../utils/logout_helper.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  int _lastPageIndex = 0;

  final List<String> _titles = [
    'Point of Sale',
    'Riwayat Pembayaran',
    'Manajemen Shift',
    'Pengaturan',
  ];

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const PosScreen(),
      const HistoryScreen(),
      const ShiftScreen(),
      const SettingsScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: _buildDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            PosHeader(
              title: _titles[_selectedIndex],
              showBackButton: _selectedIndex == 3,
              onLeadingTap: _selectedIndex == 3
                  ? () => setState(() {
                      _selectedIndex = _lastPageIndex;
                    })
                  : () => _scaffoldKey.currentState?.openDrawer(),
              // show the gear icon only if we are not already on the Pengaturan page
              onSettingsTap: _selectedIndex == 3
                  ? null
                  : () {
                      setState(() {
                        _lastPageIndex = _selectedIndex;
                        _selectedIndex = 3;
                      });
                    },
              trailingActions: _selectedIndex == 3
                  ? const []
                  : const [PosStatusActions()],
            ),
            const NoInternetBanner(
              showPendingSales: true,
              margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
            ),
            Expanded(
              // Using IndexedStack allows preserving the state of POS screen (e.g. cart contents being visible/rebuilt efficiently)
              // Since CartState is global it's fine either way, but IndexedStack prevents full rebuilds
              child: IndexedStack(index: _selectedIndex, children: _pages),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              return DrawerHeader(
                decoration: const BoxDecoration(color: AppColors.primary),
                child: authState.maybeWhen(
                  authenticated: (token, user) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white24,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        user.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        user.role.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.storefront,
                            color: Colors.white70,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              user.outlet?.name ?? 'No Outlet',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  orElse: () => const SizedBox.shrink(),
                ),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.point_of_sale,
            title: 'Point of Sale',
            index: 0,
          ),
          _buildDrawerItem(
            icon: Icons.history,
            title: 'Riwayat Pembayaran',
            index: 1,
          ),
          _buildDrawerItem(
            icon: Icons.event_note,
            title: 'Manajemen Shift',
            index: 2,
          ),
          const Spacer(),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.error),
            title: const Text(
              'Tutup Shift & Log Out',
              style: TextStyle(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              LogoutHelper.handleLogout(context);
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    final isSelected = _selectedIndex == index;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFECFDF5) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? const Color(0xFF059669) : const Color(0xFF64748B),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? const Color(0xFF059669)
                : const Color(0xFF475569),
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        onTap: () => _onItemTapped(index),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
