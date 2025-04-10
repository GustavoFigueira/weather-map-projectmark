class Weather {
  final double temperature;
  final int humidity;
  final int pressure;

  Weather({
    required this.temperature,
    required this.humidity,
    required this.pressure,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: (json['main']['temp'] as num).toDouble(),
      humidity: json['main']['humidity'] as int,
      pressure: json['main']['pressure'] as int,
    );
  }
}
