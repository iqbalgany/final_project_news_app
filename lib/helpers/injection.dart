import 'package:final_project_news_app/blocs/auth/auth_cubit.dart';
import 'package:final_project_news_app/data/local_storage/auth_local_storage.dart';
import 'package:final_project_news_app/data/local_storage/news_local_storage.dart';
import 'package:final_project_news_app/models/news/news_model.dart';
import 'package:final_project_news_app/models/source/source_model.dart';
import 'package:final_project_news_app/models/user/user_model.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupSigleton() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapter
  if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(UserModelAdapter());
  if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(NewsModelAdapter());
  if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(SourceModelAdapter());

  try {
    // Open boxes
    await Hive.openBox<UserModel>('users');
    await Hive.openBox('currentUser');

    await Hive.openBox('saved_news');
  } catch (e) {
    // ✅ Kalau error, hapus dan buat ulang
    await Hive.deleteBoxFromDisk('users');

    await Hive.deleteBoxFromDisk('currentUser');

    await Hive.deleteBoxFromDisk('saved_news');

    await Hive.openBox<UserModel>('users');

    await Hive.openBox('currentUser');

    await Hive.openBox('saved_news');
  }

  getIt.registerLazySingleton<NewsLocalStorage>(() => NewsLocalStorage());

  // Register services
  getIt.registerLazySingleton<AuthLocalStorage>(() => AuthLocalStorage());

  getIt.registerLazySingleton<AuthCubit>(
    () => AuthCubit(getIt<AuthLocalStorage>()),
  );
}
