import 'package:base_source_flutter/features/weather/data/datasources/weather_datasource.dart';

class RemoteDataSource implements WeatherDataSource {
  @override
  Future<void> getWeather() {
    throw UnimplementedError();
  }
}
