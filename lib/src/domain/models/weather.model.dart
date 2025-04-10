class WeatherModel {
  final double temperature;
  final int humidity;
  final int pressure;

  WeatherModel({
    required this.temperature,
    required this.humidity,
    required this.pressure,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: (json['main']['temp'] as num).toDouble(),
      humidity: json['main']['humidity'] as int,
      pressure: json['main']['pressure'] as int,
    );
  }
}
