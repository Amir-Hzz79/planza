import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return state is ThemeLoadingState
              ? CircularProgressIndicator()
              : MaterialApp(
                  title: 'Planza',
                  theme: state is DarkModeState ? darkTheme : lightTheme,
                  /* darkTheme: lightTheme, */
                  debugShowCheckedModeBanner: false,
                  home: SafeArea(
                    child: const HomePage(),
                  ),
                );
        },
      ),
    );
  }
}
