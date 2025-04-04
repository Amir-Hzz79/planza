import 'package:flutter/material.dart';

class CircleBackButton extends StatelessWidget {
  const CircleBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            borderRadius: BorderRadius.circular(50),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
              child: Icon(
                Icons.arrow_back_rounded,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
