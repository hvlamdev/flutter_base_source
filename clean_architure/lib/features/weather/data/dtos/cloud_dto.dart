class CloudsDTO {
  final int? all;

  CloudsDTO({
    this.all,
  });

  factory CloudsDTO.fromJson(Map<String, dynamic> json) => CloudsDTO(
    all: json["all"],
  );

  Map<String, dynamic> toJson() => {
    "all": all,
  };
}
