import 'package:final_project_news_app/models/user_model.dart';
import 'package:hive/hive.dart';

class UserService {
  Future<Box<UserModel>> _openBox() async {
    return await Hive.openBox<UserModel>('users');
  }

  Future<void> register(UserModel user) async {
    final box = await _openBox();
    try {
      await box.put(user.email, user);
      await box.flush();
    } finally {
      await box.close();
    }
  }

  Future<UserModel?> login(String email, String password) async {
    final box = await _openBox();
    try {
      final user = box.get(email);
      if (user != null && user.password == password) {
        return user;
      }
      return null;
    } finally {
      await box.close();
    }
  }

  Future<void> updateProfile(UserModel user) async {
    final box = await _openBox();
    try {
      await box.put(user.email, user);
      await box.flush();
    } finally {
      await box.close();
    }
  }

  Future<UserModel?> getUser(String email) async {
    final box = await _openBox();
    try {
      return box.get(email);
    } finally {
      await box.close();
    }
  }
}
