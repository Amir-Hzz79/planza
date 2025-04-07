import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/goal_bloc.dart';
import '../../bloc/goal_state.dart';
import '../widgets/goal_counter/goal_counter_section.dart';
import '../widgets/task_chart/task_chart.dart';
import 'package:http/http.dart' as http;

class GoalPage extends StatefulWidget {
  const GoalPage({super.key});

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  String responseChat = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<GoalBloc, GoalState>(
          builder: (context, state) {
            if (state is GoalLoadedState) {
              return GoalCounterSection(
                goals: state.goals,
              );
            } else if (state is GoalErrorState) {
              return Text('Error: ${state.message}');
            } else {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            }
          },
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<GoalBloc, GoalState>(
          builder: (context, state) {
            if (state is GoalLoadedState) {
              return TaskChart(
                goals: state.goals,
              );
            } else if (state is GoalErrorState) {
              return Text('Error: ${state.message}');
            } else {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            }
          },
        ),
        TextButton(
          onPressed: () {
            setState(() {
              responseChat = '';
            });
          },
          child: Text('Clear'),
        ),
        TextButton(
          onPressed: () async {
            /* final Response response = await http.post(
              Uri.parse('http://10.0.2.2:11434/api/chat'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(
                {
                  "model": "deepseek-r1:1.5b",
                  "messages": [
                    [
                      {
                        "role": "user",
                        "content":
                            "I want to build a fitness routine, including running, yoga, and strength training, and finish by the end of the year."
                      },
                      {
                        "role": "assistant",
                        "content":
                            "You are helping to create goals and tasks for a task management app called Planza. Based on the description provided by the user, generate a structured response with one goal and a list of associated tasks. The output should be formatted as JSON, strictly adhering to the following schema:\nGoal:\n- id: Integer (optional, will be auto-incremented in the database if omitted)\n- name: String (short title for the goal)\n- description: String (detailed description of the goal, nullable)\n- deadline: DateTime (nullable, optional deadline for the goal)\n- completed: Boolean (default false, to indicate goal completion status)\n- color: Integer (numeric value representing a color)\nTasks:\n- id: Integer (optional, auto-incremented in the database if omitted)\n- title: String (short title for the task)\n- description: String (detailed description of the task, nullable)\n- isCompleted: Boolean (default false, to indicate task completion status)\n- dueDate: DateTime (nullable, optional deadline for the task)\n- priority: Integer (nullable, priority level of the task, where 1 is highest)\n- parentTaskId: Integer (nullable, reference to parent task for subtasks)\nPlease respond ONLY with the JSON object for the goal and tasks, without any additional text or formatting."
                      }
                    ]
                  ]
                },
              ),
            );
            print(response.body);

            print(response.body.runtimeType); */

            final request = http.Request(
              'POST',
              Uri.parse(
                  'http://10.0.2.2:11434/api/chat'), // Adjust localhost URL to emulator's address
            );

            request.headers.addAll({
              'Content-Type': 'application/json; charset=UTF-8',
            });

            request.body = jsonEncode({
              "model": "deepseek-r1:1.5b",
              "messages": [
                {
                  "role": "user",
                  "content":
                      "I want to build a fitness routine, including running, yoga, and strength training, and finish by the end of the year."
                },
                {
                  "role": "assistant",
                  "content":
                      "You are helping to create goals and tasks for a task management app called Planza. Based on the description provided by the user, generate a structured response with one goal and a list of associated tasks. The output should be formatted as JSON, strictly adhering to the following schema:\nGoal:\n- id: Integer (optional, will be auto-incremented in the database if omitted)\n- name: String (short title for the goal)\n- description: String (detailed description of the goal, nullable)\n- deadline: DateTime (nullable, optional deadline for the goal)\n- completed: Boolean (default false, to indicate goal completion status)\n- color: Integer (numeric value representing a color)\nTasks:\n- id: Integer (optional, auto-incremented in the database if omitted)\n- title: String (short title for the task)\n- description: String (detailed description of the task, nullable)\n- isCompleted: Boolean (default false, to indicate task completion status)\n- dueDate: DateTime (nullable, optional deadline for the task)\n- priority: Integer (nullable, priority level of the task, where 1 is highest)\n- parentTaskId: Integer (nullable, reference to parent task for subtasks)\nPlease respond ONLY with the JSON object for the goal and tasks, without any additional text or formatting."
                }
              ],
            });

            final responseStream = await http.Client().send(request);

            responseStream.stream.transform(utf8.decoder).listen((chunk) {
              final jsonData = jsonDecode(chunk);
              String message = jsonData['message']['content'];

              print(message);
              setState(
                () {
                  responseChat += message;
                },
              );
            }, onDone: () {
              print('Streaming complete');
            }, onError: (error) {
              print('Error occurred: $error');
            });
          },
          child: Text('call deepseek'),
        ),
        Text(responseChat),
      ],
    );
  }
}
