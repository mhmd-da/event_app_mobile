import 'package:flutter/material.dart';
import 'package:event_app/core/theme/app_colors.dart';
import 'package:event_app/core/theme/app_spacing.dart';

class AppDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final void Function(T?)? onChanged;
  final Widget? prefixIcon;
  final String? label;
  final String? hint;
  final String? helper;
  final String? errorText;
  final bool outlined;
  final bool dense;
  final EdgeInsetsGeometry? contentPadding;
  final bool enabled;
  final String? Function(T?)? validator;

  const AppDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.itemLabel,
    this.onChanged,
    this.prefixIcon,
    this.label,
    this.hint,
    this.helper,
    this.errorText,
    this.outlined = true,
    this.dense = true,
    this.contentPadding,
    this.enabled = true,
    this.validator,
  });

  InputBorder _outline(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: 1),
      );

  InputBorder _underline(Color color) => UnderlineInputBorder(
        borderSide: BorderSide(color: color, width: 1),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final focusedColor = theme.colorScheme.primary;
    final errorColor = theme.colorScheme.error;
    final fillColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;

    final InputBorder enabledBorder = outlined ? _outline(borderColor) : _underline(borderColor);
    final InputBorder focusedBorder = outlined ? _outline(focusedColor) : _underline(focusedColor);
    final InputBorder errorBorder = outlined ? _outline(errorColor) : _underline(errorColor);

    final decoration = InputDecoration(
      labelText: label,
      hintText: hint,
      helperText: helper,
      errorText: errorText,
      prefixIcon: prefixIcon,
      prefixIconConstraints: prefixIcon != null
          ? const BoxConstraints(minWidth: 40, minHeight: 40)
          : null,
      isDense: dense,
      filled: true,
      fillColor: fillColor,
      contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: AppSpacing.small, vertical: 12),
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      focusedErrorBorder: errorBorder,
    );

    return DropdownButtonFormField<T>(
      value: value,
      items: items
          .map(
            (e) => DropdownMenuItem<T>(
              value: e,
              child: Text(itemLabel(e)),
            ),
          )
          .toList(),
      onChanged: enabled ? onChanged : null,
      isExpanded: true,
      dropdownColor: fillColor,
      decoration: decoration,
      validator: validator,
    );
  }
}
