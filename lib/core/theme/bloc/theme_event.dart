// ignore_for_file: use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../data/services/theme_prefrence_servie.dart';

abstract class ThemeEvent extends Equatable {
  final ThemePreferenceService _preferenceService =
      GetIt.instance.get<ThemePreferenceService>();

  @override
  List<Object> get props => [];
}

class ThemeChangeEvent extends ThemeEvent {
  ThemeChangeEvent();

  Future savePrefrence(Brightness themeMode) async =>
      await _preferenceService.saveThemeMode(themeMode);
}

class LoadThemeEvent extends ThemeEvent {
  final BuildContext context;

  LoadThemeEvent(this.context);

  Future<Brightness> getPrefrence() async {
    final prefrenceThemeMode = await _preferenceService.getThemeMode();

    //Create theme prefrence if it doesnt exist
    if (prefrenceThemeMode == null) {
      final brightness = MediaQuery.of(context).platformBrightness;
      await _preferenceService
          .saveThemeMode(brightness); //Default is system theme

      return brightness;
    }

    return prefrenceThemeMode;
  }
}
