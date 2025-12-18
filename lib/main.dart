import 'package:final_project_news_app/blocs/auth_cubit.dart';
import 'package:final_project_news_app/utils/injection.dart';
import 'package:final_project_news_app/utils/routes.dart';
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
