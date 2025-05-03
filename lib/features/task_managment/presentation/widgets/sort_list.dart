import 'package:flutter/material.dart';
import 'package:planza/core/locale/app_localization.dart';

import '../../../../core/constants/sort_ordering.dart';

enum SortTypes {
  date,
  goal,
  priority,
}

class SortList extends StatefulWidget {
  const SortList({super.key, required this.onChange});

  final void Function(SortTypes newSortType, SortOrdering newSortOrder)
      onChange;

  @override
  State<SortList> createState() => _SortListState();
}

class _SortListState extends State<SortList> {
  SortTypes selectedSortType = SortTypes.date;
  SortOrdering selectedSortOrder = SortOrdering.ascending;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalization = AppLocalizations.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 2,
      children: [
        PopupMenuButton<SortTypes>(
          tooltip: 'Sort',
          splashRadius: 0,
          onSelected: (SortTypes value) {
            setState(() {
              selectedSortType = value;

              widget.onChange.call(selectedSortType, selectedSortOrder);
            });
          },
          itemBuilder: (BuildContext context) {
            return SortTypes.values.map((SortTypes option) {
              return PopupMenuItem<SortTypes>(
                value: option,
                child: Text(option.name),
              );
            }).toList();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.sort_rounded),
              Text(appLocalization.translate(selectedSortType.name)),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          width: 2,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.grey,
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              selectedSortOrder = selectedSortOrder == SortOrdering.descending
                  ? SortOrdering.ascending
                  : SortOrdering.descending;

              widget.onChange.call(selectedSortType, selectedSortOrder);
            });
          },
          icon: AnimatedRotation(
            duration: Duration(milliseconds: 300),
            turns: selectedSortOrder == SortOrdering.descending ? 0.5 : 0,
            child: Icon(
              Icons.arrow_upward_rounded,
              key: ValueKey<SortOrdering>(selectedSortOrder),
            ),
          ),
        ),
      ],
    );
  }
}
