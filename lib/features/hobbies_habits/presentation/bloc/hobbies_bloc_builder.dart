import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/data/models/hobby_model.dart';
import 'hobbies_bloc.dart';

class HobbiesBlocBuilder extends StatelessWidget {
  const HobbiesBlocBuilder({
    super.key,
    required this.onDataLoaded,
  });

  final Widget Function(List<HobbyModel> hobbies) onDataLoaded;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HobbiesBloc, HobbiesState>(
      builder: (context, state) {
        List<HobbyModel> hobbies = state is HobbiesLoaded
            ? state.hobbies
            : [];
        return Skeletonizer(
          enabled: state is! HobbiesLoaded,
          child: onDataLoaded.call(hobbies),
        );
      },
    );
  }
}
