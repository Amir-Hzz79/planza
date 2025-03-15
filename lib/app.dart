import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/home/presentation/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: const HomePage(),
      ),
    );
  }
}
