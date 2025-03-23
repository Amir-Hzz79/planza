import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/locale/app_localization.dart';
import 'package:planza/core/locale/bloc/locale_bloc.dart';
import 'package:planza/core/locale/bloc/locale_event.dart';
import 'package:planza/core/locale/bloc/locale_state.dart';
import 'package:planza/core/theme/app_theme.dart';
import 'package:planza/core/theme/bloc/theme_bloc.dart';
import 'package:planza/core/theme/bloc/theme_event.dart';

import 'package:planza/core/theme/bloc/theme_state.dart';
import 'package:planza/features/home/bloc/goal_bloc.dart';

import 'features/home/bloc/goal_evet.dart';
import 'features/home/presentation/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GoalBloc()..add(LoadGoalsEvent()),
        ),
        BlocProvider(
          create: (context) => ThemeBloc()..add(LoadThemeEvent(context)),
        ),
        BlocProvider(
          create: (context) => LocaleBloc()..add(LoadLocaleEvent(context)),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LocaleBloc, LocaleState>(
            builder: (context, localeState) {
              return (themeState is ThemeLoadingState) ||
                      (localeState is LocaleLoadingState)
                  ? CircularProgressIndicator()
                  : MaterialApp(
                      title: 'Planza',
                      theme:
                          themeState is DarkModeState ? darkTheme : lightTheme,
                      /* darkTheme: lightTheme, */
                      debugShowCheckedModeBanner: false,
                      locale: (localeState as LocaleLoadedState).locale,
                      supportedLocales: [
                        Locale('en'), // English
                        Locale('fa'), // Farsi
                      ],
                      localizationsDelegates: [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      home: SafeArea(
                        child: const HomePage(),
                      ),
                    );
            },
          );
        },
      ),
    );
  }
}
