import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:planza/core/theme/app_theme.dart';

class ThemeState extends Equatable {
  @override
  List<Object> get props => [];

  ThemeData? get theme => null;
}

class ThemeLoadingState extends ThemeState {
  /* @override
  ThemeData get theme => lightTheme; */
}

class DarkModeState extends ThemeState {
  @override
  ThemeData get theme => darkTheme;
}

class LightModeState extends ThemeState {
  @override
  ThemeData get theme => lightTheme;
}
