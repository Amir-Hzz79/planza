import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LocaleState extends Equatable {
  const LocaleState();

  @override
  List<Object?> get props => [];
}

class LocaleLoadingState extends LocaleState {}

class LocaleLoadedState extends LocaleState {
  final Locale locale;

  const LocaleLoadedState(this.locale);

  @override
  List<Object?> get props => [locale];
}
