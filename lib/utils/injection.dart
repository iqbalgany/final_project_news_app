import 'package:final_project_news_app/blocs/auth_cubit.dart';
import 'package:final_project_news_app/data/locat_storage/auth_service.dart';
import 'package:final_project_news_app/models/user_model.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupSigleton() async {
  print('🔧 Setup Dependencies - START');

  // Initialize Hive
  await Hive.initFlutter();
  print('✅ Hive initialized');

  // Register Hive adapter
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(UserModelAdapter());
    print('✅ UserModelAdapter registered');
  } else {
    print('⚠️ UserModelAdapter already registered');
  }

  try {
    // Open boxes
    await Hive.openBox<UserModel>('users');
    await Hive.openBox('currentUser');
    print('✅ Hive boxes opened');
  } catch (e) {
    print('❌ Error opening boxes: $e');

    // ✅ Kalau error, hapus dan buat ulang
    print('🗑️ Clearing corrupt boxes...');
    await Hive.deleteBoxFromDisk('users');
    await Hive.deleteBoxFromDisk('currentUser');

    print('📦 Reopening boxes...');
    await Hive.openBox<UserModel>('users');
    await Hive.openBox('currentUser');
    print('✅ Boxes recreated successfully');
  }

  // Register services
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(getIt<AuthService>()));

  print('✅ AuthService registered');
  print('✅ AuthCubit registered');
  print('🔧 Setup Dependencies - COMPLETE');
}
