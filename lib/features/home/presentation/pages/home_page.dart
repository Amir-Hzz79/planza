import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

import '../../bloc/goal_bloc.dart';
import '../../bloc/goal_evet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /* late Future<List<GoalModel>> futureGoals; */

  @override
  void initState() {
    context.read<GoalBloc>().add(LoadGoalsEvent());
    super.initState();
  }

  DateTime selectedDate = DateTime.now();

  /*  final String sentence =
      "Got it! You can achieve this using Stream to emit words one by one with a delay, and then display them in a Text widget using StreamBuilder";

  Stream<String> wordStream(String sentence) async* {
    final words = sentence.split(' '); // Split the sentence into words
    String showingText = '';
    for (String word in words) {
      await Future.delayed(Duration(milliseconds: 300)); // Add a delay

      showingText += '$word ';

      yield showingText; // Emit the word
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EasyDateTimeLinePicker(
          focusedDate: selectedDate,
          firstDate: DateTime(DateTime.now().year, 1, 1),
          lastDate: DateTime(DateTime.now().year, 12, 31),
          onDateChange: (date) {
            setState(
              () {
                selectedDate = date;
              },
            );
          },
          selectionMode: SelectionMode.autoCenter(),
          ignoreUserInteractionOnAnimating: true,
        ),
        const SizedBox(
          height: 20,
        ),
        /* StreamBuilder<String>(
          stream: wordStream(sentence),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show loading state
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Text(
                snapshot.data!,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              );
            }
            return Text('Stream Completed!'); // When all words are shown
          },
        ), */
        /* ReorderableListView(
            children: [
              Text('1'),
            ],
            onReorder: (oldIndex, newIndex) {},
          ), */
        const SizedBox(
          height: 1000,
        ),
      ],
    );
  }
}
