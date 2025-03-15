import 'package:flutter/material.dart';
import 'package:planza/app.dart';

import 'core/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initServices();

  runApp(const MyApp());
}
