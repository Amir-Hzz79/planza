import 'package:flutter/material.dart';
import '../../tokens/index.dart';

class PlTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? suffix;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final EdgeInsetsGeometry? contentPadding;
  final PlTextFieldStyle style;

  const PlTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffix,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding,
    this.style = PlTextFieldStyle.outlined,
  });

  @override
  State<PlTextField> createState() => _PlTextFieldState();
}

class _PlTextFieldState extends State<PlTextField> {
  late bool _obscureText;
  late FocusNode _focusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode = FocusNode();
    _focusNode.addListener(() => setState(() => _hasFocus = _focusNode.hasFocus));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? PlDarkColors : PlColors;
    final hasError = widget.errorText != null;

    Color fillColor;
    Color borderColor;
    double borderWidth;

    switch (widget.style) {
      case PlTextFieldStyle.filled:
        fillColor = colors.surfaceVariant;
        borderColor = hasError ? colors.error : (_hasFocus ? colors.primary : Colors.transparent);
        borderWidth = 1.5;
        break;
      case PlTextFieldStyle.outlined:
        fillColor = colors.surface;
        borderColor = hasError ? colors.error : (_hasFocus ? colors.primary : colors.outline);
        borderWidth = _hasFocus ? 2 : 1;
        break;
      case PlTextFieldStyle.underlined:
        fillColor = Colors.transparent;
        borderColor = hasError ? colors.error : (_hasFocus ? colors.primary : colors.outlineVariant);
        borderWidth = _hasFocus ? 2 : 1;
        break;
    }

    final border = widget.style == PlTextFieldStyle.underlined
        ? UnderlineInputBorder(borderSide: BorderSide(color: borderColor, width: borderWidth))
        : OutlineInputBorder(
            borderRadius: PlBorderRadius.radiusMd,
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          );

    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      validator: widget.validator,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      textCapitalization: widget.textCapitalization,
      style: PlTypography.bodyLarge,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        helperText: widget.helperText,
        errorText: widget.errorText,
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: colors.onSurfaceVariant, size: 20)
            : null,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: colors.onSurfaceVariant,
                  size: 20,
                ),
                onPressed: () => setState(() => _obscureText = !_obscureText),
              )
            : widget.suffix,
        filled: widget.style != PlTextFieldStyle.underlined,
        fillColor: fillColor,
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        errorBorder: border.copyWith(
          borderSide: BorderSide(color: colors.error, width: 1.5),
        ),
        focusedErrorBorder: border.copyWith(
          borderSide: BorderSide(color: colors.error, width: 2),
        ),
        disabledBorder: border.copyWith(
          borderSide: BorderSide(color: colors.outlineVariant, width: 1),
        ),
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: PlSpacing.md, vertical: PlSpacing.sm),
        labelStyle: PlTypography.bodyMedium.copyWith(color: colors.onSurfaceVariant),
        hintStyle: PlTypography.bodyMedium.copyWith(color: colors.onSurfaceVariant.withOpacity(0.5)),
        helperStyle: PlTypography.bodySmall.copyWith(color: colors.onSurfaceVariant),
        errorStyle: PlTypography.bodySmall.copyWith(color: colors.error),
        counterStyle: PlTypography.bodySmall.copyWith(color: colors.onSurfaceVariant),
        alignLabelWithHint: widget.maxLines != null && widget.maxLines! > 1,
      ),
    );
  }
}

enum PlTextFieldStyle { filled, outlined, underlined }
