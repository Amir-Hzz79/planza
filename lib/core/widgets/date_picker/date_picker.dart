import 'package:flutter/material.dart';
import 'package:planza/core/utils/extention_methods/date_time_extentions.dart';

import '../../locale/app_localization.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key, required this.title, required this.onChange});

  final String title;
  final void Function(DateTime? selectedDate) onChange;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () async {
        //TODO: Find a suitable date picker
        selectedDate = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(
            Duration(days: 365),
          ),
        );

        widget.onChange.call(selectedDate);

        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.timelapse_rounded,
              color: Colors.grey,
              size: 15,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              selectedDate?.formatShortDate() ??
                  AppLocalizations.of(context).translate('task.dueDate'),
              style: Theme.of(context).textTheme.labelSmall,
            ),
            if (selectedDate != null)
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  setState(() {
                    selectedDate = null;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Icon(
                    Icons.clear_rounded,
                    color: Colors.grey,
                    size: 15,
                  ),
                ),
              )
          ],
        ),
      ),
      /* ListTile(
        leading: selectedDate != null
            ? InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  setState(() {
                    selectedDate = null;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Icon(
                    Icons.clear_rounded,
                    color: Colors.grey,
                  ),
                ),
              )
            : null,
        title: Text(widget.title),
        trailing: Text(
          selectedDate?.formatShortDate() ??
              AppLocalizations.of(context).translate('choose_date'),
        ),
      ), */
    );
  }
}
