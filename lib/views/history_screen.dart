import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme.dart';
import '../viewmodels/farm_viewmodel.dart';
import '../viewmodels/settings_viewmodel.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FarmViewModel>();
    final settings = context.watch<SettingsViewModel>();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).brightness == Brightness.light ? AppColors.textMainLight : AppColors.textMainDark),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(settings.translate('sensors'), style: AppStyles.header(context).copyWith(fontSize: 20)),
          actions: [
            IconButton(icon: const Icon(Icons.filter_list, color: AppColors.primary), onPressed: () {}),
          ],
          bottom: const TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textLight,
            indicatorColor: AppColors.primary,
            tabs: [
              Tab(text: 'All Data'),
              Tab(text: 'Today'),
              Tab(text: 'Critical'),
              Tab(text: 'Past Week'),
            ],
          ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: viewModel.history.length,
          itemBuilder: (context, index) {
            final reading = viewModel.history[index];
            return _HistoryCard(reading: reading);
          },
        ),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final dynamic reading; // Using dynamic for now or SensorReading

  const _HistoryCard({required this.reading});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'OCT 24, 2023 | 14:30 PM', // Placeholder for actual date formatting
                style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textLight),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: const Text('STABLE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _MiniSensor(icon: Icons.thermostat, label: 'Temp', value: '${reading.temperature}°C', color: Colors.orange),
              _MiniSensor(icon: Icons.water_drop, label: 'Hum', value: '${reading.humidity}%', color: Colors.blue),
              _MiniSensor(icon: Icons.water_drop, label: 'Moist', value: '${reading.soilMoisture}%', color: AppColors.primary),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniSensor extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _MiniSensor({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textLight)),
        Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
