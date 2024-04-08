class CoordDTO {
  final double? lon;
  final double? lat;

  CoordDTO({
    this.lon,
    this.lat,
  });

  factory CoordDTO.fromJson(Map<String, dynamic> json) => CoordDTO(
        lon: json["lon"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
      };
}
