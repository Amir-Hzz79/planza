import 'package:flutter/material.dart';
import 'package:planza/core/utils/extention_methods/date_time_extentions.dart';

import '../buttons/custom_icon_button.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    this.initialDate,
    this.title,
    required this.onChange,
    this.showRemoveIcon = true,
    this.showSelectedDate = true,
    this.showIconWhenDateSelected = false,
    this.iconSize,
  });

  final DateTime? initialDate;
  final String? title;
  final double? iconSize;
  final bool showIconWhenDateSelected;
  final bool showRemoveIcon;
  final bool showSelectedDate;
  final void Function(DateTime? selectedDate) onChange;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? selectedDate;

  @override
  void initState() {
    selectedDate = widget.initialDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
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
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selectedDate == null ? true : widget.showIconWhenDateSelected)
            Icon(
              Icons.more_time_rounded,
              color: selectedDate == null
                  ? Colors.grey
                  : Theme.of(context).colorScheme.primary,
              size: widget.iconSize,
            ),
          if ((selectedDate != null || widget.title != null) &&
              widget.showSelectedDate)
            const SizedBox(
              width: 5,
            ),
          if ((selectedDate != null || widget.title != null) &&
              widget.showSelectedDate)
            Text(
              selectedDate?.formatShortDate() ?? widget.title ?? '',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          if (selectedDate != null && widget.showRemoveIcon)
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
    );
  }
}
