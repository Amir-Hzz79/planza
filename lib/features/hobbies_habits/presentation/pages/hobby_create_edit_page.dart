import 'package:flutter/material.dart';
import 'package:planza/core/data/models/hobby_model.dart';
import 'package:planza/core/design/primitives/pl_button.dart';
import 'package:planza/core/design/primitives/pl_text_field.dart';
import 'package:planza/core/design/tokens/border_radius.dart';
import 'package:planza/core/design/tokens/spacing.dart';
import 'package:planza/core/design/tokens/typography.dart';

class HobbyCreateEditDialog extends StatefulWidget {
  final HobbyModel? hobby;
  final Function(HobbyModel) onSave;

  const HobbyCreateEditDialog({
    super.key,
    this.hobby,
    required this.onSave,
  });

  @override
  State<HobbyCreateEditDialog> createState() => _HobbyCreateEditDialogState();
}

class _HobbyCreateEditDialogState extends State<HobbyCreateEditDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _customFrequencyController = TextEditingController();

  String _selectedCategory = 'Custom';
  String _selectedFrequency = 'daily';
  IconData? _selectedIcon;
  int? _selectedColor;
  int? _targetDuration;
  String _customFrequency = '';

  final _categories = ['Habit', 'Project', 'Learning', 'Fitness', 'Custom'];
  final _frequencies = ['daily', 'weekly', 'custom'];
  final _icons = [
    Icons.track_changes,
    Icons.fitness_center,
    Icons.auto_stories,
    Icons.code,
    Icons.palette,
    Icons.music_note,
    Icons.restaurant,
    Icons.directions_run,
    Icons.self_improvement,
    Icons.psychology,
  ];
  final _colors = [
    0xFF6366F1, // Indigo
    0xFF14B8A6, // Teal
    0xFF22C55E, // Green
    0xFFF97316, // Orange
    0xFFEF4444, // Red
    0xFFEC4899, // Pink
    0xFF8B5CF6, // Violet
    0xFF06B6D4, // Cyan
    0xFFEAB308, // Yellow
    0xFFF472B6, // Pink
  ];

  @override
  void initState() {
    super.initState();
    if (widget.hobby != null) {
      _nameController.text = widget.hobby!.name;
      _descriptionController.text = widget.hobby!.description ?? '';
      _selectedCategory = widget.hobby!.category;
      _selectedFrequency = widget.hobby!.frequency;
      _selectedIcon =
          widget.hobby!.icon != null ? IconData(widget.hobby!.icon!) : null;
      _selectedColor = widget.hobby!.color;
      _targetDuration = widget.hobby!.targetDurationMinutes;
      _customFrequency = widget.hobby!.customFrequencyJson ?? '';
      _customFrequencyController.text = widget.hobby!.customFrequencyJson ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _customFrequencyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      title: Text(
        widget.hobby == null ? 'Create Hobby' : 'Edit Hobby',
        style: PlTypography.headlineSmall,
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              PlTextField(
                controller: _nameController,
                label: 'Name',
                hint: 'e.g., Morning Run',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: PlSpacing.md),

              // Description
              PlTextField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Optional description',
                maxLines: 3,
              ),
              const SizedBox(height: PlSpacing.md),

              // Category
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(
                    borderRadius: PlBorderRadius.radiusMd,
                  ),
                ),
                items: _categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) {
                  setState(() => _selectedCategory = value!);
                },
              ),
              const SizedBox(height: PlSpacing.md),

              // Frequency
              DropdownButtonFormField<String>(
                value: _selectedFrequency,
                decoration: InputDecoration(
                  labelText: 'Frequency',
                  border: OutlineInputBorder(
                    borderRadius: PlBorderRadius.radiusMd,
                  ),
                ),
                items: _frequencies
                    .map((f) => DropdownMenuItem(
                          value: f,
                          child: Text(f.capitalize()),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFrequency = value!;
                    if (value != 'custom') {
                      _customFrequency = '';
                      _customFrequencyController.clear();
                    }
                  });
                },
              ),
              const SizedBox(height: PlSpacing.md),

              // Custom frequency
              if (_selectedFrequency == 'custom') ...[
                PlTextField(
                  controller: _customFrequencyController,
                  label: 'Custom Pattern',
                  hint: 'e.g., every_3_days, every_2_weeks, monthly_day_15',
                ),
                const SizedBox(height: PlSpacing.sm),
                Text(
                  'Patterns: every_N_days, every_N_weeks, monthly_day_N',
                  style: PlTypography.bodySmall.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: PlSpacing.md),
              ],

              // Target Duration
              PlTextField(
                label: 'Target Duration (minutes)',
                hint: 'e.g., 30',
                keyboardType: TextInputType.number,
                controller: TextEditingController(
                  text: _targetDuration?.toString() ?? '',
                ),
                onChanged: (value) {
                  _targetDuration = int.tryParse(value);
                },
              ),
              const SizedBox(height: PlSpacing.md),

              // Icon picker
              Text('Icon', style: PlTypography.labelLarge),
              const SizedBox(height: PlSpacing.xs),
              Wrap(
                spacing: PlSpacing.sm,
                runSpacing: PlSpacing.sm,
                children: _icons.map((icon) {
                  final isSelected = _selectedIcon == icon;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedIcon = icon),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primaryContainer
                            : Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
                        borderRadius: PlBorderRadius.radiusMd,
                        border: isSelected
                            ? Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2,
                              )
                            : null,
                      ),
                      child: Icon(
                        icon,
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                        size: 24,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: PlSpacing.md),

              // Color picker
              Text('Color', style: PlTypography.labelLarge),
              const SizedBox(height: PlSpacing.xs),
              Wrap(
                spacing: PlSpacing.sm,
                runSpacing: PlSpacing.sm,
                children: _colors.map((color) {
                  final isSelected = _selectedColor == color;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedColor = color),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(color),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                          width: isSelected ? 3 : 0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: isSelected
                          ? const Icon(Icons.check,
                              color: Colors.white, size: 20)
                          : null,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: PlTypography.labelLarge),
        ),
        PlButton.primary(
          label: widget.hobby == null ? 'Create' : 'Save',
          onPressed: _save,
        ),
      ],
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final hobby = HobbyModel(
      id: widget.hobby?.id ?? 0,
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      category: _selectedCategory,
      icon: _selectedIcon?.codePoint,
      color: _selectedColor,
      frequency: _selectedFrequency,
      customFrequencyJson: _selectedFrequency == 'custom'
          ? _customFrequencyController.text.trim().isEmpty
              ? null
              : _customFrequencyController.text.trim()
          : null,
      targetDurationMinutes: _targetDuration,
      goalId: null, // Could be added later
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    widget.onSave(hobby);
    Navigator.pop(context);
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
