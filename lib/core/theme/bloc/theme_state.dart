part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  @override
  List<Object> get props => [];

  ThemeData? get theme => null;
}

class ThemeLoadingState extends ThemeState {}

class DarkModeState extends ThemeState {
  @override
  ThemeData get theme => darkTheme;
}

class LightModeState extends ThemeState {
  @override
  ThemeData get theme => lightTheme;
}
