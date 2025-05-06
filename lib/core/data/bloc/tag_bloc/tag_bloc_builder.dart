import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../models/tag_model.dart';
import '../../models/task_model.dart';
import 'tag_bloc.dart';

class TagBlocBuilder extends StatelessWidget {
  const TagBlocBuilder({super.key, required this.onDataLoaded});

  final Widget Function(List<TagModel> tags) onDataLoaded;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagBloc, TagState>(
      builder: (context, state) {
        List<TagModel> goals = state is TagsLoadedState
            ? state.tags
            : List.generate(
                8,
                (index) => TagModel(
                  id: index,
                  name: 'place holder',
                  tasks: [
                    TaskModel(
                      id: index,
                      title: 'place holder',
                      dueDate: DateTime.now()
                          .subtract(Duration(days: 5))
                          .add(Duration(days: index)),
                    ),
                    TaskModel(
                      id: index,
                      title: 'place holder',
                      dueDate: DateTime.now()
                          .subtract(Duration(days: 5))
                          .add(Duration(days: index)),
                    ),
                  ],
                ),
              );

        return Skeletonizer(
          enabled: state is! TagsLoadedState /* true */,
          child: onDataLoaded.call(goals),
        );
      },
    );
  }
}
