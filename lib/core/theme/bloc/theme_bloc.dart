import 'package:flutter/material.dart' show Brightness;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeLoadingState()) {
    on<LoadThemeEvent>((event, emit) async {
      final Brightness prefrenceThemeMode = await event.getPrefrence();

      emit(
        prefrenceThemeMode == Brightness.dark
            ? DarkModeState()
            : LightModeState(),
      );
    });

    on<ThemeChangeEvent>((event, emit) {
      event.savePrefrence(
        state is DarkModeState ? Brightness.light : Brightness.dark,
      );

      state is DarkModeState ? emit(LightModeState()) : emit(DarkModeState());
    });
  }
}
