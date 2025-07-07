import 'dart:ui' show PlatformDispatcher;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show BuildContext, Locale;
import 'package:get_it/get_it.dart';
import 'package:planza/core/services/locale_prefrence_service.dart';

abstract class LocaleEvent extends Equatable {
  final LocalePreferenceService _preferenceService =
      GetIt.instance.get<LocalePreferenceService>();

  @override
  List<Object> get props => [];
}

class LocaleChangeEvent extends LocaleEvent {
  LocaleChangeEvent();

  Future savePrefrence(Locale locale) async =>
      await _preferenceService.saveLocale(locale);
}

class LoadLocaleEvent extends LocaleEvent {
  final BuildContext context;

  LoadLocaleEvent(this.context);

  Future<Locale> getPrefrence() async {
    final prefrenceLocale = await _preferenceService.getLocale();
    if (prefrenceLocale != null) {
      return prefrenceLocale;
    }

    final systemLocale = PlatformDispatcher.instance.locale;

    // 1. Check if the user's device language is Farsi.
    if (systemLocale.languageCode == 'fa') {
      const farsiLocale = Locale('fa', 'IR');
      await _preferenceService.saveLocale(farsiLocale);
      return farsiLocale;
    } else {
      // 2. For EVERYONE else, ALWAYS default to the full Locale('en', 'US').
      const englishLocale = Locale('en', 'US');
      await _preferenceService.saveLocale(englishLocale);
      return englishLocale;
    }
  }
}
