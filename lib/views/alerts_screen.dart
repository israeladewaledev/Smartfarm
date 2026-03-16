import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme.dart';
import '../viewmodels/settings_viewmodel.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsViewModel>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(settings.translate('alerts'), style: AppStyles.header(context)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _AlertItem(
            title: 'Critical Soil Moisture',
            message: 'Station A2 is below 30%. Immediate irrigation recommended.',
            time: '2 mins ago',
            type: AlertType.critical,
          ),
          _AlertItem(
            title: 'High Temperature Warning',
            message: 'Air temperature exceeded 38°C. Check crop stress.',
            time: '1 hour ago',
            type: AlertType.warning,
          ),
          _AlertItem(
            title: 'Power Source Low',
            message: 'Solar battery level at 15%. System entering power save.',
            time: 'Today, 8:12 AM',
            type: AlertType.warning,
          ),
        ],
      ),
    );
  }
}

enum AlertType { critical, warning, info }

class _AlertItem extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final AlertType type;

  const _AlertItem({required this.title, required this.message, required this.time, required this.type});

  @override
  Widget build(BuildContext context) {
    Color color = type == AlertType.critical ? AppColors.alertRed : AppColors.warningYellow;
    IconData icon = type == AlertType.critical ? Icons.warning_rounded : Icons.info_outline;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(message, style: const TextStyle(fontSize: 13, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
