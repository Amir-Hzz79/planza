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
            child: CircleAvatar(
              backgroundColor: Colors.grey[200],
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
