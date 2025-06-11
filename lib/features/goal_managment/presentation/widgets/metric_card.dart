import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';

class MetricCard extends StatelessWidget {
  final Widget child;
  final String label;

  const MetricCard({
    super.key,
    required this.child,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacityDouble(0.2),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                child, // The main content (e.g., a number or chart)
                const SizedBox(height: 8.0),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacityDouble(0.8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
