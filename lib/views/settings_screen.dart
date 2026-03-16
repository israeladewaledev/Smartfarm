import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../viewmodels/settings_viewmodel.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsViewModel>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).brightness == Brightness.light ? AppColors.textMainLight : AppColors.textMainDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(settings.translate('settings'), style: AppStyles.header(context).copyWith(fontSize: 20)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionHeader(title: 'PREFERENCES'),
            _SettingTile(
              icon: Icons.dark_mode,
              title: 'Dark Mode',
              subtitle: 'Switch application theme',
              trailing: Switch(
                value: settings.themeMode == ThemeMode.dark,
                onChanged: (_) => settings.toggleTheme(),
                activeThumbColor: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            const _SectionHeader(title: 'LANGUAGE'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Wrap(
                spacing: 8,
                children: [
                  _LangChip(label: 'English', code: 'en', isActive: settings.locale.languageCode == 'en', onTap: () => settings.setLocale('en')),
                  _LangChip(label: 'Hausa', code: 'ha', isActive: settings.locale.languageCode == 'ha', onTap: () => settings.setLocale('ha')),
                  _LangChip(label: 'Yoruba', code: 'yo', isActive: settings.locale.languageCode == 'yo', onTap: () => settings.setLocale('yo')),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const _SectionHeader(title: 'GENERAL NOTIFICATIONS'),
            _SettingTile(
              icon: Icons.notifications_none,
              title: 'Push Notifications',
              subtitle: 'Push updates for crop health',
              trailing: Switch(
                value: true,
                onChanged: (v) {},
                activeThumbColor: AppColors.primary,
              ),
            ),
            _SettingTile(
              icon: Icons.message_outlined,
              title: 'Critical Alerts Only',
              subtitle: 'Standard messaging rates apply',
              trailing: Switch(
                value: false,
                onChanged: (v) {},
                activeThumbColor: AppColors.primary,
              ),
            ),
            
            const SizedBox(height: 32),
            const _SectionHeader(title: 'THRESHOLD CONFIGURATION'),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Critical Moisture Level', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text('Trigger alert when below this %', style: AppStyles.subheader(context)),
                        ],
                      ),
                      Text('30%', style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Slider(
                    value: 30,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    activeColor: AppColors.primary,
                    onChanged: (v) {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            const _SectionHeader(title: 'DEVICE INFO'),
            _InfoTile(label: 'Firmware Version', value: 'v2.4.12-stable'),
            _InfoTile(label: 'Last Cloud Sync', value: '2 mins ago'),
            _InfoTile(label: 'Battery Status', value: '88%', isBattery: true),
            
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                child: const Text('LOGOUT', style: TextStyle(color: AppColors.alertRed, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(title, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textLight, letterSpacing: 1.2)),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget trailing;

  const _SettingTile({required this.icon, required this.title, required this.subtitle, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
                Text(subtitle, style: AppStyles.subheader(context).copyWith(fontSize: 12)),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}

class _LangChip extends StatelessWidget {
  final String label;
  final String code;
  final bool isActive;
  final VoidCallback onTap;

  const _LangChip({required this.label, required this.code, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(label, style: TextStyle(color: isActive ? Colors.white : AppColors.primary, fontWeight: FontWeight.bold)),
        backgroundColor: isActive ? AppColors.primary : AppColors.primary.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide.none),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final bool isBattery;

  const _InfoTile({required this.label, required this.value, this.isBattery = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textDark)),
          Row(
            children: [
              if (isBattery) const Icon(Icons.battery_std, size: 16, color: AppColors.primary),
              if (isBattery) const SizedBox(width: 4),
              Text(value, style: GoogleFonts.inter(color: isBattery ? AppColors.primary : AppColors.textLight, fontWeight: isBattery ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
        ],
      ),
    );
  }
}
