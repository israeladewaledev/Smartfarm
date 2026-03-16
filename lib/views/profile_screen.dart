import '../theme.dart';
import 'edit_bio_screen.dart';
import 'security_settings_screen.dart';
import 'system_support_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Farmer Profile'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text('Aaliyah Abdulmalik', style: AppStyles.header(context)),
            Text('Lead Farmer | ID: FM-8821', style: AppStyles.subheader(context)),
            const SizedBox(height: 32),
            
            _InfoRow(icon: Icons.location_on, label: 'Farm Location', value: 'Minna, Niger State'),
            _InfoRow(icon: Icons.agriculture, label: 'Crop Type', value: 'Maize & Cassava'),
            _InfoRow(icon: Icons.calendar_today, label: 'Member Since', value: 'Jan 2024'),
            
            const SizedBox(height: 40),
            
            _ActionTile(
              icon: Icons.edit, 
              title: 'Edit Bio',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditBioScreen())),
            ),
            _ActionTile(
              icon: Icons.security, 
              title: 'Security Settings',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SecuritySettingsScreen())),
            ),
            _ActionTile(
              icon: Icons.help_outline, 
              title: 'System Support',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SystemSupportScreen())),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ActionTile({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.withValues(alpha: 0.1))),
      ),
    );
  }
}
