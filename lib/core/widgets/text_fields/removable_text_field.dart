import 'package:flutter/material.dart';

class RemovableTextField extends StatelessWidget {
  const RemovableTextField({
    super.key,
    required this.hintText,
    required this.onRemove,
    this.controller,
  });

  final String hintText;
  final void Function() onRemove;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        /* mainAxisSize: MainAxisSize.min, */
        children: [
          Expanded(
            flex: 4,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: onRemove,
              icon: Icon(Icons.close_rounded),
            ),
          )
        ],
      ),
    );
  }
}
