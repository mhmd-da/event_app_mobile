import 'package:event_app/core/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/theme/app_colors.dart';

class AppTextInput extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final String? helper;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final bool outlined;
  final bool dense;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final String? initialValue;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function(String)? onSubmitted;

  const AppTextInput({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helper,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.outlined = true,
    this.dense = true,
    this.contentPadding,
    this.textInputAction,
    this.autofocus = false,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.onSubmitted,
  });

  @override
  State<AppTextInput> createState() => _AppTextInputState();
}

class _AppTextInputState extends State<AppTextInput> {
  late bool _obscured;

  @override
  void initState() {
    super.initState();
    _obscured = widget.isPassword ? true : widget.obscureText;
    // Seed controller if provided and initialValue present
    if (widget.controller != null && widget.initialValue != null && widget.controller!.text.isEmpty) {
      widget.controller!.text = widget.initialValue!;
    }
  }

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

    final InputBorder enabledBorder = widget.outlined ? _outline(borderColor) : _underline(borderColor);
    final InputBorder focusedBorder = widget.outlined ? _outline(focusedColor) : _underline(focusedColor);
    final InputBorder errorBorder = widget.outlined ? _outline(errorColor) : _underline(errorColor);

    final suffix = widget.isPassword
        ? _PasswordToggle(obscured: _obscured, onToggle: () => setState(() => _obscured = !_obscured))
        : (widget.suffixIcon != null
          ? _ClickableSuffix(onTap: widget.onSuffixTap, child: widget.suffixIcon!)
          : null);

    final bool hasPrefix = widget.prefixIcon != null;
    final decoration = InputDecoration(
      labelText: widget.label,
      hintText: widget.hint,
      helperText: widget.helper,
      errorText: widget.errorText,
      prefixIcon: widget.prefixIcon,
      prefixIconConstraints: hasPrefix
          ? const BoxConstraints(minWidth: 40, minHeight: 40)
          : null,
      suffixIcon: suffix,
      isDense: widget.dense,
      filled: true,
      fillColor: fillColor,
      contentPadding: widget.contentPadding ??
          EdgeInsets.symmetric(
            horizontal: AppSpacing.small,
            vertical: hasPrefix ? 18 : 12,
          ),
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      focusedErrorBorder: errorBorder,
      counterText: '',
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    );

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      initialValue: widget.controller == null ? widget.initialValue : null,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? _obscured : widget.obscureText,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      minLines: widget.minLines,
      maxLines: widget.maxLines == 1 && (widget.isPassword || widget.obscureText) ? 1 : widget.maxLines,
      maxLength: widget.maxLength,
      textInputAction: widget.textInputAction,
      autofocus: widget.autofocus,
      style: AppTextStyles.bodyMedium,
      decoration: decoration,
      onChanged: widget.onChanged,
      validator: widget.validator,
      onFieldSubmitted: widget.onSubmitted,
    );
  }
}

class _PasswordToggle extends StatelessWidget {
  final bool obscured;
  final VoidCallback onToggle;
  const _PasswordToggle({required this.obscured, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      onPressed: onToggle,
      icon: Icon(obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined),
      tooltip: obscured ? 'Show' : 'Hide',
    );
  }
}

class _ClickableSuffix extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  const _ClickableSuffix({required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (onTap == null) return child;
    return GestureDetector(behavior: HitTestBehavior.opaque, onTap: onTap, child: child);
  }
}
