import 'package:flutter/material.dart';

class DrawerListButton extends StatelessWidget {
  const DrawerListButton(
      {super.key, required this.text, required this.icon, this.onTap});

  final String text;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        title: Text(text),
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(
            icon,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
