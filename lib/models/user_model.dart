import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final String? phoneNumber;

  @HiveField(4)
  final String? name;

  @HiveField(5)
  final String? address;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
    this.phoneNumber,
    this.name,
    this.address,
  });
}
