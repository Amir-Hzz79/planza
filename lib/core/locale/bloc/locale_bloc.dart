import 'package:flutter/material.dart' show Locale;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/locale/bloc/locale_event.dart';
import 'package:planza/core/locale/bloc/locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(LocaleLoadingState()) {
    on<LoadLocaleEvent>((event, emit) async {
      final Locale prefrenceLocale = await event.getPrefrence();

      emit(LocaleLoadedState(prefrenceLocale));
    });

    on<LocaleChangeEvent>((event, emit) {
      Locale newLocale =
          (state as LocaleLoadedState).locale.languageCode == 'fa'
              ? Locale('en', 'US')
              : Locale('fa', 'IR');

      event.savePrefrence(newLocale);

      emit(LocaleLoadedState(newLocale));
    });
  }
}
