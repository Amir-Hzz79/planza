import 'dart:math';
import 'package:flutter/material.dart';

class DynamicSizeTextFormField extends StatefulWidget {
  const DynamicSizeTextFormField({
    super.key,
    this.onLeave,
    this.hint,
    required this.titleController,
    this.validator,
    this.minWidth = 50,
    this.maxWidth = 150,
  });

  final String? hint;
  final TextEditingController titleController;
  final void Function(String? newValue)? onLeave;
  final String? Function(String? value)? validator;
  final double minWidth;
  final double maxWidth;

  @override
  State<DynamicSizeTextFormField> createState() =>
      _DynamicSizeTextFormFieldState();
}

class _DynamicSizeTextFormFieldState extends State<DynamicSizeTextFormField> {
  double textWidth = 100;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    textWidth = _calculateTextWidth(widget.titleController.text);
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        widget.onLeave?.call(widget.titleController.text);
      }
    });
  }

  double _calculateTextWidth(String text) {
    TextPainter painter = TextPainter(
      text: TextSpan(
        text: text,
        /* style: Theme.of(context).textTheme.labelSmall, */
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    return painter.width + 20; // Add padding
  }

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: max(widget.minWidth, min(textWidth, widget.maxWidth)),
          child: TextFormField(
            controller: widget.titleController,
            focusNode: _focusNode,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.labelSmall,
            decoration: InputDecoration(
              filled: true,
              /* label: widget.label, */
              hintText: widget.hint,
              hintStyle: Theme.of(context).textTheme.labelSmall,
              fillColor: Theme.of(context).colorScheme.surfaceContainer,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onSaved: widget.onLeave,
            validator: widget.validator,
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            onChanged: (text) {
              setState(() {
                textWidth = _calculateTextWidth(text);
              });
            },
          ),
        );
      },
    );
  }
}
