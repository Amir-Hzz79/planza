import 'package:flutter/material.dart';
import 'package:planza/core/data/bloc/tag_bloc/tag_bloc_builder.dart';
import 'package:planza/core/data/models/tag_model.dart';
import 'package:planza/core/widgets/buttons/custom_icon_button.dart';

class TagSelection extends StatefulWidget {
  const TagSelection({
    super.key,
    required this.onTagAdded,
    required this.selected,
    required this.onTagRemoved,
  });

  final void Function(TagModel selectedTag) onTagAdded;
  final void Function(TagModel selectedTag) onTagRemoved;
  final bool Function(TagModel tag) selected;

  @override
  State<TagSelection> createState() => _TagSelectionState();
}

class _TagSelectionState extends State<TagSelection> {
  @override
  Widget build(BuildContext context) {
    return TagBlocBuilder(onDataLoaded: (tags) {
      return CustomIconButton(
        onTap: () => showModalBottomSheet(
          context: context,
          showDragHandle: true,
          isScrollControlled: true,
          builder: (context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter sheetSetState) {
                return IntrinsicHeight(
                  child: Column(
                    children: tags.map(
                      (tag) {
                        bool tagSelected = widget.selected.call(tag);
                        return ListTile(
                          selected: tagSelected,
                          leading: const Icon(Icons.tag_rounded),
                          title: Text(tag.name),
                          trailing: Checkbox(
                            value: tagSelected,
                            onChanged: (value) {
                              sheetSetState(() {
                                if (value!) {
                                  widget.onTagAdded.call(tag);
                                } else {
                                  widget.onTagRemoved.call(tag);
                                }
                              });
                            },
                          ),
                        );
                      },
                    ).toList(),
                  ),
                );
              },
            );
          },
        ),
        icon: const Icon(
          Icons.tag_rounded,
          color: Colors.grey,
        ),
      );
    });
  }
}
