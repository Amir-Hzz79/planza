import 'package:flutter/material.dart';
import 'package:planza/features/task_managment/presentation/widgets/add_task_fields.dart';

import '../../../../core/widgets/text_fields/removable_text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddTaskFields(),
      ],
    );
  }
}
