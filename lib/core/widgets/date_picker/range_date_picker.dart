import 'package:flutter/material.dart';
import 'package:planza/core/utils/extention_methods/date_time_extentions.dart';

import '../../locale/app_localization.dart';

class RangeDatePicker extends StatefulWidget {
  const RangeDatePicker({super.key, required this.title});

  final String title;

  @override
  State<RangeDatePicker> createState() => _RangeDatePickerState();
}

class _RangeDatePickerState extends State<RangeDatePicker> {
  DateTime? selectedFromDate;
  DateTime? selectedToDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.title,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Colors.grey),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (selectedFromDate != null)
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    setState(() {
                      selectedFromDate = null;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Icon(
                      Icons.clear_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            Expanded(
              flex: selectedFromDate == null ? 5 : 4,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () async {
                  //TODO: Find a suitable date picker
                  selectedFromDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: selectedToDate ??
                        DateTime.now().add(
                          Duration(days: 365),
                        ),
                  );

                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Center(
                    child: Text(selectedFromDate?.formatShortDate() ??
                        AppLocalizations.of(context).translate('start_date')),
                  ),
                ),
              ),
            ),
            Expanded(child: Icon(Icons.arrow_forward_rounded)),
            Expanded(
              flex: selectedToDate == null ? 5 : 4,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () async {
                  //TODO: Find a suitable date picker
                  selectedToDate = await showDatePicker(
                    context: context,
                    firstDate: selectedFromDate ?? DateTime.now(),
                    lastDate: DateTime.now().add(
                      Duration(days: 365),
                    ),
                  );

                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Center(
                    child: Text(
                      selectedToDate?.formatShortDate() ??
                          AppLocalizations.of(context).translate('end_date'),
                    ),
                  ),
                ),
              ),
            ),
            if (selectedToDate != null)
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    setState(
                      () {
                        selectedToDate = null;
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Icon(
                      Icons.clear_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
          ],
        ),
        Divider(
          indent: 10,
          endIndent: 10,
          thickness: 0.5,
          height: 1,
          color: Colors.grey,
        ),
      ],
    );
  }
}
