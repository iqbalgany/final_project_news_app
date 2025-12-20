import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(ThemeData.light());

  void toggleTheme() {
    if (state.brightness == Brightness.dark) {
      final lightBase = ThemeData.light();
      emit(
        lightBase.copyWith(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(backgroundColor: Colors.white),
          textTheme: GoogleFonts.poppinsTextTheme(lightBase.textTheme),
        ),
      );
    } else {
      emit(
        ThemeData(
          brightness: Brightness.dark,
          iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.white),
            ),
          ),
        ),
      );
    }
  }
}
