import 'dart:ui' show PlatformDispatcher;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show BuildContext, Locale;
import 'package:get_it/get_it.dart';
import 'package:planza/core/data/services/locale_prefrence_service.dart';
import 'package:planza/core/locale/app_localization.dart';

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

    //Create locale prefrence if it doesnt exist
    if (prefrenceLocale == null) {
      final systemLocale = PlatformDispatcher.instance.locale;

      if (AppLocalizations.delegate.isSupported(systemLocale)) {
        await _preferenceService
            .saveLocale(systemLocale); //Use device locale if app support

        return systemLocale;
      } else {
        return AppLocalizations.defaultLocale;
      }
    }

    return prefrenceLocale;
  }
}
