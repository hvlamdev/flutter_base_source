class WindDTO {
  final double? speed;
  final int? deg;
  final double? gust;

  WindDTO({
    this.speed,
    this.deg,
    this.gust,
  });

  factory WindDTO.fromJson(Map<String, dynamic> json) => WindDTO(
    speed: json["speed"]?.toDouble(),
    deg: json["deg"],
    gust: json["gust"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "speed": speed,
    "deg": deg,
    "gust": gust,
  };
}