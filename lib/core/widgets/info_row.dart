import 'package:flutter/material.dart';
import 'app_buttons.dart';
import 'package:flutter/services.dart';
import 'notifier.dart';

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool copyable;
  final VoidCallback? onTap;
  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.copyable = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          if (copyable)
            AppIconButton(
              icon: const Icon(Icons.copy, size: 18),
              color: theme.hintColor,
              tooltip: 'Copy',
              onPressed: () {
                Clipboard.setData(ClipboardData(text: value));
                AppNotifier.bottomMessage(context, 'Copied to clipboard');
              },
            ),
        ],
      ),
    );
  }
}
