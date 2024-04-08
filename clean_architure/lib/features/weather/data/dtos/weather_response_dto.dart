import 'package:base_source_flutter/features/weather/data/dtos/cloud_dto.dart';
import 'package:base_source_flutter/features/weather/data/dtos/coord_dto.dart';
import 'package:base_source_flutter/features/weather/data/dtos/main_dto.dart';
import 'package:base_source_flutter/features/weather/data/dtos/rain_dto.dart';
import 'package:base_source_flutter/features/weather/data/dtos/sys_dto.dart';
import 'package:base_source_flutter/features/weather/data/dtos/weather_dto.dart';
import 'package:base_source_flutter/features/weather/data/dtos/wind_dto.dart';

class WeatherResponseDTO {
  final CoordDTO? coord;
  final List<WeatherDTO>? weather;
  final String? base;
  final MainDTO? main;
  final int? visibility;
  final WindDTO? wind;
  final RainDTO? rain;
  final CloudsDTO? clouds;
  final int? dt;
  final SysDTO? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  WeatherResponseDTO({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.rain,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory WeatherResponseDTO.fromJson(Map<String, dynamic> json) => WeatherResponseDTO(
    coord: json["coord"] == null ? null : CoordDTO.fromJson(json["coord"]),
    weather: json["weather"] == null ? [] : List<WeatherDTO>.from(json["weather"]!.map((x) => WeatherDTO.fromJson(x))),
    base: json["base"],
    main: json["main"] == null ? null : MainDTO.fromJson(json["main"]),
    visibility: json["visibility"],
    wind: json["wind"] == null ? null : WindDTO.fromJson(json["wind"]),
    rain: json["rain"] == null ? null : RainDTO.fromJson(json["rain"]),
    clouds: json["clouds"] == null ? null : CloudsDTO.fromJson(json["clouds"]),
    dt: json["dt"],
    sys: json["sys"] == null ? null : SysDTO.fromJson(json["sys"]),
    timezone: json["timezone"],
    id: json["id"],
    name: json["name"],
    cod: json["cod"],
  );

  Map<String, dynamic> toJson() => {
    "coord": coord?.toJson(),
    "weather": weather == null ? [] : List<dynamic>.from(weather!.map((x) => x.toJson())),
    "base": base,
    "main": main?.toJson(),
    "visibility": visibility,
    "wind": wind?.toJson(),
    "rain": rain?.toJson(),
    "clouds": clouds?.toJson(),
    "dt": dt,
    "sys": sys?.toJson(),
    "timezone": timezone,
    "id": id,
    "name": name,
    "cod": cod,
  };
}








