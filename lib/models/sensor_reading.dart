class SensorReading {
  final String? id;
  final double temperature;
  final double humidity;
  final double soilMoisture;
  final DateTime createdAt;
  final String? nodeId;

  SensorReading({
    this.id,
    required this.temperature,
    required this.humidity,
    required this.soilMoisture,
    required this.createdAt,
    this.nodeId,
  });

  factory SensorReading.fromJson(Map<String, dynamic> json) {
    return SensorReading(
      id: json['id']?.toString(),
      temperature: (json['temperature'] as num).toDouble(),
      humidity: (json['humidity'] as num).toDouble(),
      soilMoisture: (json['soil_moisture'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      nodeId: json['node_id']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'humidity': humidity,
      'soil_moisture': soilMoisture,
      'created_at': createdAt.toIso8601String(),
      'node_id': nodeId,
    };
  }
}
