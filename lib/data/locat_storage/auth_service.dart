import 'package:final_project_news_app/models/user_model.dart';
import 'package:hive/hive.dart';

class AuthService {
  static const String _userBox = 'users';
  static const String _currentUserBox = 'currentUser';

  Box<UserModel> get _userBoxInstance => Hive.box<UserModel>(_userBox);
  Box get _currentUserBoxInstance => Hive.box(_currentUserBox);

  Future<void> _safePut(String key, UserModel user) async {
    try {
      await _userBoxInstance.put(key, user);
    } catch (e) {
      print('❌ Error putting to Hive: $e');

      print('🗑️ Clearing corrupt data...');
      await _userBoxInstance.clear();
      await _userBoxInstance.put(key, user);
      print('✅ Retry successful');
    }
  }

  Future<UserModel> register({
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    print(
      '🔵 REGISTER - Email: $email, Password: $password, Phone: $phoneNumber',
    );

    final existingUser = _userBoxInstance.values.firstWhere(
      (user) => user.email == email,
      orElse: () => UserModel(email: '', password: '', phoneNumber: ''),
    );

    if (existingUser.email.isNotEmpty) {
      print('❌ REGISTER - Email sudah terdaftar!');
      throw Exception('Email sudah terdaftar');
    }

    final newUser = UserModel(
      email: email,
      password: password,
      phoneNumber: phoneNumber,
    );

    await _safePut(newUser.id, newUser);

    print('✅ REGISTER - Berhasil! User ID: ${newUser.id}');
    print('📦 Total users di database: ${_userBoxInstance.length}');

    return newUser;
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    print('🔵 LOGIN - Email: $email, Password: $password');

    print('📦 Total users di database: ${_userBoxInstance.length}');
    print('🗄️ Box path: ${_userBoxInstance.path}');
    print('📝 Box name: ${_userBoxInstance.name}');

    print('👥 Semua users:');
    for (var user in _userBoxInstance.values) {
      print('   - Email: ${user.email}, Password: ${user.password}');
    }

    final user = _userBoxInstance.values.firstWhere(
      (user) => user.email == email && user.password == password,
      orElse: () => UserModel(email: '', password: '', phoneNumber: ''),
    );

    if (user.email.isEmpty) {
      print('❌ LOGIN - Email atau password salah!');
      throw Exception('Email atau password salah');
    }

    await _currentUserBoxInstance.put('userId', user.id);

    print('✅ LOGIN - Berhasil! User: ${user.email}');

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
    print(
      '🔵 UPDATE PROFILE - userId: $userId, name: $name, address: $address',
    );

    try {
      final user = _userBoxInstance.get(userId);
      if (user == null) {
        throw Exception('User tidak ditemukan');
      }

      final updateUser = user.copyWith(name: name, address: address);

      await _safePut(userId, updateUser);

      return updateUser;
    } catch (e) {
      print('❌ UPDATE PROFILE ERROR: $e');
      print('   Error type: ${e.runtimeType}');

      if (e.toString().contains('HiveError')) {
        print('🗑️ Detected corrupt data, clearing...');
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
