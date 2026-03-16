import 'package:flutter/material.dart';
import '../models/sensor_reading.dart';
import '../services/supabase_service.dart';
import '../services/connectivity_service.dart';
import '../services/local_storage_service.dart';

class FarmViewModel extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  final ConnectivityService _connectivityService = ConnectivityService();
  final LocalStorageService _localStorageService = LocalStorageService();

  SensorReading? _latestReading;
  List<SensorReading> _history = [];
  bool _isOnline = false;
  bool _isLoading = true;

  SensorReading? get latestReading => _latestReading;
  List<SensorReading> get history => _history;
  bool get isOnline => _isOnline;
  bool get isLoading => _isLoading;

  FarmViewModel() {
    _init();
  }

  Future<void> _init() async {
    _isOnline = await _connectivityService.isConnected;
    
    // Listen for connectivity changes
    _connectivityService.connectionStream.listen((online) {
      _isOnline = online;
      if (online) {
        _syncWithCloud();
      }
      notifyListeners();
    });

    // Initial data load
    if (_isOnline) {
      await _syncWithCloud();
    } else {
      await _loadFromCache();
    }

    // Listen for real-time updates if online
    _supabaseService.sensorStream.listen((readings) {
      if (readings.isNotEmpty) {
        _latestReading = readings.last;
        _history = readings.reversed.toList();
        _localStorageService.cacheHistory(_history);
        notifyListeners();
      }
    });

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _syncWithCloud() async {
    try {
      _history = await _supabaseService.fetchHistory();
      if (_history.isNotEmpty) {
        _latestReading = _history.first;
        await _localStorageService.cacheHistory(_history);
      }
    } catch (e) {
      debugPrint("Sync Error: $e");
    }
  }

  Future<void> _loadFromCache() async {
    _history = await _localStorageService.getCachedHistory();
    if (_history.isNotEmpty) {
      _latestReading = _history.first;
    }
  }
}
