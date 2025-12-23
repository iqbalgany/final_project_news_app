import 'package:final_project_news_app/models/user/user_model.dart';
import 'package:hive/hive.dart';

class AuthLocalStorage {
  static const String _userBox = 'users';
  static const String _currentUserBox = 'currentUser';

  Box<UserModel> get _userBoxInstance => Hive.box<UserModel>(_userBox);
  Box get _currentUserBoxInstance => Hive.box(_currentUserBox);

  Future<void> _safePut(String key, UserModel user) async {
    try {
      await _userBoxInstance.put(key, user);
    } catch (e) {
      await _userBoxInstance.clear();

      await _userBoxInstance.put(key, user);
    }
  }

  Future<UserModel> register({
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    final existingUser = _userBoxInstance.values.firstWhere(
      (user) => user.email == email,
      orElse: () => UserModel(email: '', password: '', phoneNumber: ''),
    );

    if (existingUser.email.isNotEmpty) {
      throw Exception('Email sudah terdaftar');
    }

    final newUser = UserModel(
      email: email,
      password: password,
      phoneNumber: phoneNumber,
    );

    await _safePut(newUser.id, newUser);

    return newUser;
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final user = _userBoxInstance.values.firstWhere(
      (user) => user.email == email && user.password == password,
      orElse: () => UserModel(email: '', password: '', phoneNumber: ''),
    );

    if (user.email.isEmpty) {
      throw Exception('Email atau password salah');
    }

    await _currentUserBoxInstance.put('userId', user.id);

    return user;
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final userId = _currentUserBoxInstance.get('userId');
      if (userId == null) return null;

      return _userBoxInstance.get(userId);
    } catch (e) {
      return null;
    }
  }

  Future<UserModel> updateProfile({
    required String userId,
    String? name,
    String? address,
  }) async {
    try {
      final user = _userBoxInstance.get(userId);
      if (user == null) {
        throw Exception('User tidak ditemukan');
      }

      final updateUser = user.copyWith(name: name, address: address);

      await _safePut(userId, updateUser);

      return updateUser;
    } catch (e) {
      if (e.toString().contains('HiveError')) {
        await _userBoxInstance.clear();
        await _currentUserBoxInstance.clear();
        throw Exception('Data corupt. Silahkan login ulang');
      }

      rethrow;
    }
  }

  Future<void> logout() async {
    await _currentUserBoxInstance.delete('userId');
  }
}
