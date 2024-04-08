class WeatherDTO {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  WeatherDTO({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory WeatherDTO.fromJson(Map<String, dynamic> json) => WeatherDTO(
    id: json["id"],
    main: json["main"],
    description: json["description"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main": main,
    "description": description,
    "icon": icon,
  };
}
