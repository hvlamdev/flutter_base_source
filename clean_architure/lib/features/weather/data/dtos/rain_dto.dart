class RainDTO {
  final double? the1H;

  RainDTO({
    this.the1H,
  });

  factory RainDTO.fromJson(Map<String, dynamic> json) => RainDTO(
    the1H: json["1h"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "1h": the1H,
  };
}
