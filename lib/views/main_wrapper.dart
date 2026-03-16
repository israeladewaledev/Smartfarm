import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme.dart';
import '../viewmodels/settings_viewmodel.dart';
import 'dashboard_screen.dart';
import 'history_screen.dart';
import 'alerts_screen.dart';
import 'settings_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const HistoryScreen(),
    const AlertsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsViewModel>();

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).cardColor,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textLight,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.grid_view_rounded),
              activeIcon: const Icon(Icons.grid_view_rounded, size: 28),
              label: settings.translate('dashboard'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.sensors_rounded),
              activeIcon: const Icon(Icons.sensors_rounded, size: 28),
              label: settings.translate('sensors'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.notifications_active_rounded),
              activeIcon: const Icon(Icons.notifications_active_rounded, size: 28),
              label: settings.translate('alerts'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings_suggest_rounded),
              activeIcon: const Icon(Icons.settings_suggest_rounded, size: 28),
              label: settings.translate('settings'),
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
