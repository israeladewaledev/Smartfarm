import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../theme.dart';
import '../viewmodels/farm_viewmodel.dart';
import '../viewmodels/settings_viewmodel.dart';
import 'alerts_screen.dart';
import 'history_screen.dart';
import 'settings_screen.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FarmViewModel>();
    final settings = context.watch<SettingsViewModel>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person, size: 16, color: Colors.white),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('GreenField Farms', style: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).brightness == Brightness.light ? AppColors.textMainLight : AppColors.textMainDark)),
            Text('Monitoring Station A2', style: GoogleFonts.manrope(fontSize: 12, color: Theme.of(context).brightness == Brightness.light ? AppColors.textSecondaryLight : AppColors.textSecondaryDark)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AlertsScreen())),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Top Row: Temp & Humidity
            Row(
              children: [
                Expanded(
                  child: _SensorCard(
                    label: settings.translate('temp'),
                    value: '${viewModel.latestReading?.temperature.toStringAsFixed(0) ?? "--"}°C',
                    icon: Icons.thermostat,
                    iconColor: Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _SensorCard(
                    label: settings.translate('hum'),
                    value: '${viewModel.latestReading?.humidity.toStringAsFixed(0) ?? "--"}%',
                    icon: Icons.water_drop,
                    iconColor: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Soil Moisture Gauge Card
            _MoistureCard(value: viewModel.latestReading?.soilMoisture ?? 0),

            const SizedBox(height: 20),

            // Irrigation Control Card
            _IrrigationCard(),

            const SizedBox(height: 24),
            
            // Sync Status
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.sync, size: 16, color: AppColors.textLight),
                const SizedBox(width: 8),
                Text('Last Synced: Today, 10:42 AM', style: AppStyles.subheader(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SensorCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _SensorCard({required this.label, required this.value, required this.icon, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(height: 12),
          Text(label, style: AppStyles.subheader(context)),
          const SizedBox(height: 4),
          Text(value, style: AppStyles.cardValue(context)),
        ],
      ),
    );
  }
}

class _MoistureCard extends StatelessWidget {
  final double value;

  const _MoistureCard({required this.value});

  @override
  Widget build(BuildContext context) {
    Color getStatusColor() {
      if (value > 50) return AppColors.primary;
      if (value > 30) return AppColors.warningYellow;
      return AppColors.alertRed;
    }

    String getStatusText() {
      if (value > 50) return "Adequate";
      if (value > 30) return "Alert";
      return "Critical";
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 15, offset: const Offset(0, 10))],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.eco, color: AppColors.primary, size: 16),
                  ),
                  const SizedBox(width: 12),
                  Text('Soil Moisture', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const Icon(Icons.more_horiz, color: AppColors.textLight),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 100,
                  showLabels: false,
                  showTicks: false,
                  axisLineStyle: AxisLineStyle(
                    thickness: 0.15,
                    cornerStyle: CornerStyle.bothCurve,
                    color: AppColors.surface,
                    thicknessUnit: GaugeSizeUnit.factor,
                  ),
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: value,
                      width: 0.15,
                      sizeUnit: GaugeSizeUnit.factor,
                      cornerStyle: CornerStyle.bothCurve,
                      color: getStatusColor(),
                    ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      positionFactor: 0.1,
                      widget: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${value.toStringAsFixed(0)}%', style: GoogleFonts.inter(fontSize: 48, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(getStatusText(), style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: getStatusColor())),
                          Text('Target range: 40% - 60%', style: AppStyles.subheader(context)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SENSOR ID', style: AppStyles.subheader(context)),
                  Text('SM-X204', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('CONDITION', style: AppStyles.subheader(context)),
                  Text('Optimal', style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: AppColors.primary)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IrrigationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8E9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: const Icon(Icons.water_drop, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Irrigation System', style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: AppColors.textDark)),
                Text('Scheduled for 6:00 PM', style: AppStyles.subheader(context)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
            child: const Text('AUTO', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary)),
          ),
          const SizedBox(width: 8),
          Switch(
            value: true,
            onChanged: (v) {},
            activeThumbColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
