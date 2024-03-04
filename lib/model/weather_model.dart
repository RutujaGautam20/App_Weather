class WeatherModel {
  final String city;
  final double temperature;
  final String weatherCondition;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.weatherCondition,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'],
      temperature: (json['main']['temp'] - 273.15),
      weatherCondition: json['weather'][0]['description'],
    );
  }
}
