import 'package:flutter/material.dart';

class EmptySection extends StatelessWidget {
  final IconData icon;
  final String message;
  final String? actionButtonText;
  final void Function() onActionButtonClick;

  const EmptySection({
    super.key,
    required this.icon,
    required this.message,
    this.actionButtonText,
    required this.onActionButtonClick,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
        child: Center(
          child: Column(
            children: [
              Icon(icon, size: 48, color: Colors.grey.shade400),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              if (actionButtonText != null)
                TextButton(
                  onPressed: onActionButtonClick,
                  child: Text(actionButtonText!),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
