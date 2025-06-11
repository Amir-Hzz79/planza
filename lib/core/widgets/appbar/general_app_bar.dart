import 'package:flutter/material.dart';
import 'package:planza/core/widgets/buttons/profile_button.dart';

class GeneralAppBar extends StatelessWidget {
  const GeneralAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 8,
        ),
        Builder(
          builder: (context) {
            return ProfileButton(
              onTap: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        /* const SizedBox(
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
        ), */
      ],
    );
  }
}
