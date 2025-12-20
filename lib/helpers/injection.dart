import 'package:final_project_news_app/blocs/auth/auth_cubit.dart';
import 'package:final_project_news_app/data/locat_storage/auth_service.dart';
import 'package:final_project_news_app/models/user_model.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupSigleton() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapter
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(UserModelAdapter());
  }

  try {
    // Open boxes
    await Hive.openBox<UserModel>('users');
    await Hive.openBox('currentUser');
  } catch (e) {
    // ✅ Kalau error, hapus dan buat ulang
    await Hive.deleteBoxFromDisk('users');

    await Hive.deleteBoxFromDisk('currentUser');

    await Hive.openBox<UserModel>('users');

    await Hive.openBox('currentUser');
  }

  // Register services
  getIt.registerLazySingleton<AuthService>(() => AuthService());

  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(getIt<AuthService>()));
}
