import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:planza/core/data/database/database.dart';
import 'package:planza/core/widgets/buttons/profile_button.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
                  AppDatabase db = GetIt.I.get<AppDatabase>();
                  db.insertDummyData(db);
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
