import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setLocale(String languageCode) {
    _locale = Locale(languageCode);
    notifyListeners();
  }

  // Helper for translations
  String translate(String key) {
    final Map<String, Map<String, String>> translations = {
      'en': {
        'dashboard': 'Dashboard',
        'sensors': 'Sensors',
        'alerts': 'Alerts',
        'settings': 'Settings',
        'welcome': 'Welcome Back',
        'moisture': 'Soil Moisture',
        'temp': 'Temperature',
        'hum': 'Humidity',
        'critical': 'CRITICAL',
      },
      'ha': {
        'dashboard': 'Allo',
        'sensors': 'Ma\'auni',
        'alerts': 'Gargaɗi',
        'settings': 'Saituna',
        'welcome': 'Barka da Dawowa',
        'moisture': 'Danshin Kasa',
        'temp': 'Zafin Iska',
        'hum': 'Louman Iska',
        'critical': 'HADARI',
      },
      'yo': {
        'dashboard': 'Dashboard',
        'sensors': 'Awọn sensọ',
        'alerts': 'Awọn itaniji',
        'settings': 'Eto',
        'welcome': 'Kaabo pada',
        'moisture': 'Ọrinrin ile',
        'temp': 'Iwọn otutu',
        'hum': 'Iwa ọrinrin',
        'critical': 'PATAKI',
      }
    };
    return translations[_locale.languageCode]?[key] ?? key;
  }
}
