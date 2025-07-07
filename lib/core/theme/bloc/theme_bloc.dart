import 'package:flutter/material.dart' show Brightness, ThemeData;
import 'package:flutter/widgets.dart' show BuildContext, MediaQuery;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:planza/core/theme/app_theme.dart';

import '../../services/theme_prefrence_servie.dart';

part 'theme_event.dart';
part 'theme_state.dart';

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
