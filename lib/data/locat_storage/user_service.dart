import 'package:final_project_news_app/models/user_model.dart';
import 'package:hive/hive.dart';

class UserService {
  Future<Box<UserModel>> _openBox() async {
    return await Hive.openBox<UserModel>('users');
  }

  Future<void> register(UserModel user) async {
    var box = await _openBox();
    await box.put(user.email, user);
  }

  Future<UserModel?> login(String email, String password) async {
    var box = await _openBox();
    final user = box.get(email);
    if (user != null && user.password == password) {
      return user;
    }
    return null;
  }

  Future<void> updateProfile(UserModel user) async {
    var box = await _openBox();
    await box.put(user.email, user);
  }

  Future<UserModel?> getUser(String email) async {
    var box = await _openBox();
    return box.get(email);
  }
}
