import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/sensor_reading.dart';

class SupabaseService {
  final _client = Supabase.instance.client;

  // Stream of latest sensor readings
  Stream<List<SensorReading>> get sensorStream {
    return _client
        .from('sensor_readings')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .map((data) => data.map((json) => SensorReading.fromJson(json)).toList());
  }

  // Fetch historical data
  Future<List<SensorReading>> fetchHistory({int limit = 50}) async {
    final response = await _client
        .from('sensor_readings')
        .select()
        .order('created_at', ascending: false)
        .limit(limit);
    
    return (response as List).map((json) => SensorReading.fromJson(json)).toList();
  }

  // Authentication
  Future<AuthResponse> signIn(String email, String password) async {
    return await _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}
