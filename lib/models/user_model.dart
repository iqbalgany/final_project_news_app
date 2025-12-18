import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final String phoneNumber;

  @HiveField(4)
  String? name;

  @HiveField(5)
  String? address;

  UserModel({
    String? id,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.name,
    this.address,
  }) : id = id ?? const Uuid().v4();

  UserModel copyWith({
    String? email,
    String? password,
    String? phoneNumber,
    String? name,
    String? address,
  }) {
    return UserModel(
      id: id,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      address: address ?? this.address,
    );
  }
}
