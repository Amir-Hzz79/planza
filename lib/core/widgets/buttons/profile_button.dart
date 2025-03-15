import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key, this.onTap, this.radius});

  final GestureTapCallback? onTap;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/profile.JPEG'),
          radius: radius,
        ),
      ),
    );
  }
}
