import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'viewmodels/farm_viewmodel.dart';
import 'viewmodels/settings_viewmodel.dart';
import 'views/login_screen.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://buddimicnfiamdlgfvwt.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ1ZGRpbWljbmZpYW1kbGdmdnd0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzM0MDU4OTcsImV4cCI6MjA4ODk4MTg5N30.LfcE2GvBi7Dm1Gh1fkgets2htEf3PXOsZtrspr3hsTg',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FarmViewModel()),
        ChangeNotifierProvider(create: (_) => SettingsViewModel()),
      ],
      child: const SmartFarmApp(),
    ),
  );
}

class SmartFarmApp extends StatelessWidget {
  const SmartFarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsViewModel>();

    return MaterialApp(
      title: 'SmartFarm Monitor',
      debugShowCheckedModeBanner: false,
      themeMode: settings.themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.backgroundLight,
        cardColor: AppColors.surfaceLight,
        textTheme: GoogleFonts.manropeTextTheme(ThemeData.light().textTheme),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        cardColor: AppColors.surfaceDark,
        textTheme: GoogleFonts.manropeTextTheme(ThemeData.dark().textTheme).apply(
          bodyColor: AppColors.textMainDark,
          displayColor: AppColors.textMainDark,
        ),
      ),
      home:  LoginScreen(),
    );
  }
}
