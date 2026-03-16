import 'package:flutter/material.dart';
import '../theme.dart';

class SecuritySettingsScreen extends StatelessWidget {
  const SecuritySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Security Settings'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _SecurityTile(
            icon: Icons.lock_outline,
            title: 'Change Password',
            subtitle: 'Update your login credentials',
            onTap: () {},
          ),
          _SecurityTile(
            icon: Icons.fingerprint,
            title: 'Biometric Authentication',
            subtitle: 'Use fingerprint or face ID to unlock',
            isSwitch: true,
          ),
          _SecurityTile(
            icon: Icons.devices,
            title: 'Authorized Devices',
            subtitle: 'Manage devices linked to this ID',
            onTap: () {},
          ),
          _SecurityTile(
            icon: Icons.security,
            title: 'Two-Factor Authentication',
            subtitle: 'Add an extra layer of security',
            isSwitch: true,
          ),
          const SizedBox(height: 40),
          _SecurityTile(
            icon: Icons.delete_forever,
            title: 'Deactivate Account',
            subtitle: 'Permanently remove your farm data',
            color: AppColors.alertRed,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _SecurityTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSwitch;
  final Color color;
  final VoidCallback? onTap;

  const _SecurityTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isSwitch = false,
    this.color = AppColors.primary,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color == AppColors.alertRed ? color : AppColors.textDark)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: isSwitch 
          ? Switch(value: true, onChanged: (v) {}, activeThumbColor: AppColors.primary)
          : const Icon(Icons.chevron_right),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
        ),
      ),
    );
  }
}
