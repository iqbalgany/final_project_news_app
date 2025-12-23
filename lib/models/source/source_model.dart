import 'package:hive/hive.dart';

part 'source_model.g.dart';

@HiveType(typeId: 2)
class SourceModel {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? name;

  SourceModel({this.id, this.name});

  factory SourceModel.fromJson(Map<String, dynamic> json) =>
      SourceModel(id: json["id"] as String?, name: json["name"] as String?);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
