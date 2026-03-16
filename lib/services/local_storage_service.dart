import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/sensor_reading.dart';

class LocalStorageService {
  static const String _historyKey = 'sensor_history_cache';

  Future<void> cacheHistory(List<SensorReading> readings) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = readings.map((r) => r.toJson()).toList();
    await prefs.setString(_historyKey, jsonLinks(jsonList));
  }

  Future<List<SensorReading>> getCachedHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_historyKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => SensorReading.fromJson(json)).toList();
  }

  String jsonLinks(List<Map<String, dynamic>> list) {
    return jsonEncode(list);
  }
}
