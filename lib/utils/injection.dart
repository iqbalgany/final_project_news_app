import 'package:final_project_news_app/blocs/auth_cubit.dart';
import 'package:final_project_news_app/data/locat_storage/user_service.dart';
import 'package:final_project_news_app/models/user_model.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final getIt = GetIt.instance;

Future<void> setupSigleton() async {
  // Initialize Hive and register adapters
  Hive.registerAdapter(UserModelAdapter());

  getIt.registerLazySingleton<UserService>(() => UserService());
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<UserService>()));
}
