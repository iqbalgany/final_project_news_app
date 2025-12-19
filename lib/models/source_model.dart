class SourceModel {
  final String? id;
  final String? name;

  SourceModel({this.id, this.name});

  factory SourceModel.fromJson(Map<String, dynamic> json) =>
      SourceModel(id: json["id"] as String?, name: json["name"] as String?);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
