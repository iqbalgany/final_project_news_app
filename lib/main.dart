import 'package:final_project_news_app/blocs/auth/auth_cubit.dart';
import 'package:final_project_news_app/blocs/news/news_cubit.dart';
import 'package:final_project_news_app/consts/routes.dart';
import 'package:final_project_news_app/data/remote_data/news_remote_data.dart';
import 'package:final_project_news_app/helpers/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(backgroundColor: Colors.white),
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        ),
        initialRoute: AppRoutes.login,
        routes: routes,
      ),
    );
  }
}
