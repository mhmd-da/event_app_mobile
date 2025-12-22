import 'package:event_app/core/theme/app_decorations.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateTabs extends ConsumerWidget {
  const DateTabs({super.key, required this.dates, required this.selectedDate, required this.onSelect});

  final List<String> dates;
  final String? selectedDate;
  final void Function(String date) onSelect;

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {

    return Container(
      height: 70,
      alignment: Alignment.center, // ✅ centers the whole list container
      decoration: BoxDecoration(color: Theme.of(ctx).scaffoldBackgroundColor),
      child: Center(
        // ✅ Forces centering in all screen sizes
        child: ListView.separated(
          shrinkWrap: true, // important to allow centering
          scrollDirection: Axis.horizontal,
          itemCount: dates.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, i) {
            final date = dates[i];
            final isActive = selectedDate == date;

            return InkWell(
              onTap: () => onSelect(date),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: AppDecorations.tabButton(
                  ctx,
                    bgColor: isActive
                      ? Theme.of(ctx).colorScheme.primary.withValues(alpha: 0.5)
                      : Theme.of(ctx).colorScheme.primary.withValues(alpha: 0.07),
                ),
                child: Column(
                  children: [
                    Text(
                      date.split(' ').first,
                      style:
                          Theme.of(ctx).textTheme.bodyMedium ??
                          AppTextStyles.bodySmall,
                    ),
                    Text(
                      date.split(' ').last,
                      style:
                          Theme.of(ctx).textTheme.bodyMedium ??
                          AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
