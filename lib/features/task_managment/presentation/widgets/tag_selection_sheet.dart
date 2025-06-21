import 'package:flutter/material.dart';

import '../../../../core/data/models/tag_model.dart';

class TagSelectionSheet extends StatefulWidget {
  final List<TagModel> allTags;
  final List<TagModel> initialTags;
  const TagSelectionSheet(
      {super.key, required this.allTags, required this.initialTags});

  @override
  State<TagSelectionSheet> createState() => TagSelectionSheetState();
}

class TagSelectionSheetState extends State<TagSelectionSheet> {
  late Set<TagModel> _selectedTags;

  @override
  void initState() {
    super.initState();
    _selectedTags = Set.from(widget.initialTags);
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          ...List.generate(
            widget.allTags.length,
            (index) {
              final tag = widget.allTags[index];
              final isSelected = _selectedTags.contains(tag);

              return CheckboxListTile(
                title: Text(tag.name),
                value: isSelected,
                onChanged: (bool? value) {
                  setState(
                    () {
                      if (value == true) {
                        _selectedTags.add(tag);
                      } else {
                        _selectedTags.remove(tag);
                      }
                    },
                  );
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FilledButton(
              style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
              child: const Text("Done"),
              onPressed: () =>
                  Navigator.of(context).pop(_selectedTags.toList()),
            ),
          )
        ],
      ),
    );
  }
}
