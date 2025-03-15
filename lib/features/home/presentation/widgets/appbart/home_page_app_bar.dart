import 'package:flutter/material.dart';
import 'package:planza/core/widgets/buttons/profile_button.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
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
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.inverseSurface,
                child: Icon(
                  Icons.add_rounded,
                  color: Theme.of(context).colorScheme.onInverseSurface,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              CircleAvatar(
                child: Icon(
                  Icons.notifications_outlined,
                  color: Colors.black,
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
