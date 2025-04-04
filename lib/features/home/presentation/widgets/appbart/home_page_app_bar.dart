import 'package:flutter/material.dart';

import 'package:planza/core/locale/app_localization.dart';
import 'package:planza/core/widgets/buttons/profile_button.dart';
import 'package:planza/features/task_managment/presentation/widgets/add_task_fields.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 5,
              ),
              Builder(
                builder: (context) {
                  return ProfileButton(
                    onTap: () => Scaffold.of(context).openDrawer(),
                  );
                },
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AmirHosein Zamani',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Good morning',
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    ModalBottomSheetRoute(
                      showDragHandle: true,
                      builder: (context) => IntrinsicHeight(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: ListTile(
                                leading: Icon(Icons.golf_course_rounded),
                                title: Text(
                                  appLocalizations
                                      .translate('add_modal_goal_title'),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Text(
                                  appLocalizations
                                      .translate('add_modal_goal_subtitle'),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(
                                  ModalBottomSheetRoute(
                                    showDragHandle: true,
                                    builder: (context) => IntrinsicHeight(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: AddTaskFields(),
                                      ),
                                    ),
                                    isScrollControlled: true,
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: Icon(Icons.task_alt_rounded),
                                title: Text(
                                  appLocalizations
                                      .translate('add_modal_task_title'),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Text(
                                  appLocalizations
                                      .translate('add_modal_task_subtitle'),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      isScrollControlled: true,
                    ),
                  );
                },
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.inverseSurface,
                  child: Icon(
                    Icons.add_rounded,
                    color: Theme.of(context).colorScheme.onInverseSurface,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              CircleAvatar(
                child: Icon(
                  Icons.notifications_outlined,
                  /* color: Colors.black, */
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
