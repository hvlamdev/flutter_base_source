import 'package:base_source_flutter/features/weather/data/datasources/weather_datasource.dart';

class LocalDataSource implements WeatherDataSource {
  @override
  Future<void> getWeather() {
    throw UnimplementedError();
  }
}