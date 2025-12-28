import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInput extends StatefulWidget {
  const OtpInput({
    super.key,
    this.length = 6,
    this.onChanged,
    this.onCompleted,
    this.validator,
  });

  final int length;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final String? Function(String value)? validator;

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late final List<TextEditingController> _controllers;
  final _fieldKey = GlobalKey<FormFieldState<String>>();
  String _value = '';

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _updateValue() {
    _value = _controllers.map((c) => c.text).join();
    widget.onChanged?.call(_value);
    _fieldKey.currentState?.didChange(_value);
    if (_value.length == widget.length) {
      widget.onCompleted?.call(_value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(widget.length, (i) {
              return SizedBox(
                width: 48,
                child: Focus(
                  canRequestFocus: false,
                  skipTraversal: true,
                  onKeyEvent: (node, event) {
                    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
                      // If current is empty, go back and clear previous
                      if (_controllers[i].text.isEmpty && i > 0) {
                        _controllers[i - 1].text = '';
                        FocusScope.of(context).previousFocus();
                        _updateValue();
                        return KeyEventResult.handled;
                      }
                    }
                    return KeyEventResult.ignored;
                  },
                  child: TextFormField(
                    controller: _controllers[i],
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      filled: true,
                      fillColor: theme.colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (val) {
                      if (i == 0 && val.length > 1) {
                        final chars = val.replaceAll(RegExp(r"\\s"), '').split('');
                        int idx = 0;
                        for (final ch in chars) {
                          if (idx >= widget.length) break;
                          _controllers[idx].text = ch;
                          idx++;
                        }
                        if (idx < widget.length) {
                          // Move focus forward idx times
                          for (int k = 0; k < idx; k++) {
                            FocusScope.of(context).nextFocus();
                          }
                        } else {
                          FocusScope.of(context).unfocus();
                        }
                      } else {
                        if (val.isNotEmpty) {
                          if (i < widget.length - 1) {
                            FocusScope.of(context).nextFocus();
                          } else {
                            FocusScope.of(context).unfocus();
                          }
                        }
                      }
                      _updateValue();
                    },
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 8),
        FormField<String>(
          key: _fieldKey,
          validator: widget.validator == null ? null : (val) => widget.validator!(val ?? ''),
          builder: (state) {
            if (state.hasError) {
              return Text(
                state.errorText ?? '',
                style: TextStyle(color: theme.colorScheme.error),
                textAlign: TextAlign.center,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
