import 'package:final_project_news_app/blocs/auth/auth_cubit.dart';
import 'package:final_project_news_app/blocs/news/news_cubit.dart';
import 'package:final_project_news_app/blocs/theme/theme_cubit.dart';
import 'package:final_project_news_app/consts/routes.dart';
import 'package:final_project_news_app/data/remote_data/news_remote_data.dart';
import 'package:final_project_news_app/helpers/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupSigleton();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => getIt<AuthCubit>()),
        BlocProvider<NewsCubit>(
          create: (context) => NewsCubit(NewsRemoteDataImpl()),
        ),
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            initialRoute: AppRoutes.login,
            routes: routes,
          );
        },
      ),
    );
  }
}
