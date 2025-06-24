import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';

import '../../../../core/locale/app_localizations.dart';

class AchievementDetailsPage extends StatelessWidget {
  final GoalModel goal;
  const AchievementDetailsPage({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    Lang lang = Lang.of(context)!;

    return Scaffold(
      backgroundColor:
          Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24.0),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                goal.color.withOpacityDouble(0.2),
                Colors.grey.shade900.withOpacityDouble(0.2)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(color: Colors.amber, width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.emoji_events, size: 80, color: Colors.amber.shade400),
              const SizedBox(height: 16),
              Text(
                "GOAL ACHIEVED!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade400,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                goal.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),
              _buildStatRow("Tasks Completed", "${goal.tasks.length}"),
              const Divider(color: Colors.white24),
              _buildStatRow("Duration", "${goal.durationInDays} Days"),
              const Divider(color: Colors.white24),
              if (goal.completedDate != null)
                _buildStatRow("Completed On",
                    DateFormat.yMMMMd().format(goal.completedDate!)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Implement sharing logic using a package like share_plus
          // Share.share('I just completed my goal: "${goal.name}" on Planza!');
        },
        label:  Text(lang.general_share),
        icon: const Icon(Icons.share),
        backgroundColor: Colors.amber.shade400,
        foregroundColor: Colors.black,
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(color: Colors.white70, fontSize: 16)),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
