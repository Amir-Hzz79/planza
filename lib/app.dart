import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/data/bloc/goal_bloc/goal_bloc.dart';
import 'core/data/bloc/tag_bloc/tag_bloc.dart';
import 'core/data/bloc/task_bloc/task_bloc.dart';
import 'core/locale/app_localizations.dart';
import 'core/locale/bloc/locale_bloc.dart';
import 'core/locale/bloc/locale_event.dart';
import 'core/locale/bloc/locale_state.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/bloc/theme_bloc.dart';
import 'root_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc()..add(LoadThemeEvent(context)),
        ),
        BlocProvider(
          create: (context) => LocaleBloc()..add(LoadLocaleEvent(context)),
        ),
        BlocProvider(
          create: (context) => GoalBloc()..add(StartWatchingGoalsEvent()),
        ),
        BlocProvider(
          create: (context) => TaskBloc()..add(StartWatchingTasksEvent()),
        ),
        BlocProvider(
          create: (context) => TagBloc()..add(StartWatchingTagsEvent()),
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
                      debugShowCheckedModeBanner: false,
                      locale: (localeState as LocaleLoadedState).locale,
                      supportedLocales: Lang.supportedLocales,
                      localizationsDelegates: [
                        Lang.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      home: SafeArea(
                        child: const RootPage(),
                      ),
                    );
            },
          );
        },
      ),
    );
  }
}
