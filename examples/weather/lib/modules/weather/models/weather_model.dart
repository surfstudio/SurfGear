import 'dart:convert';

class WeatherData {
  final String city;
  final int temperaure;
  final String main; // Clouds
  final String description; // Shatterd Clouds
  final int pressure;
  final int humidity;
  final int windSpeed;

  WeatherData(this.city, this.temperaure, this.main, this.description,
      this.pressure, this.humidity, this.windSpeed);

  @override
  String toString() {
    return 'WeatherData(city: $city, temperaure: $temperaure, main: $main, description: $description, pressure: $pressure, humidity: $humidity, windSpeed: $windSpeed)';
  }
}
