import 'package:event_app/core/theme/app_colors.dart';
import 'package:event_app/core/theme/app_decorations.dart';
import 'package:event_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

enum ListingViewType { imageCard, list }

class ListingViewToggle extends StatelessWidget {
  final ListingViewType value;
  final ValueChanged<ListingViewType> onChanged;
  final EdgeInsetsGeometry padding;
  final double iconSize;

  const ListingViewToggle({
    super.key,
    required this.value,
    required this.onChanged,
    this.padding = const EdgeInsets.all(AppSpacing.xSmall),
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    final bg = AppDecorations.tabButton(context).color;

    Widget buildButton({required IconData icon, required ListingViewType type}) {
      final isSelected = value == type;
      final color = isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).iconTheme.color;
      final selectedBg = isSelected ? (AppColors.lightSurface) : bg;

      return InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onChanged(type),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.small),
          decoration: AppDecorations.tabButton(context, bgColor: selectedBg),
          child: Icon(icon, size: iconSize, color: color),
        ),
      );
    }

    return Row(
      children: [
        buildButton(icon: Icons.grid_view_rounded, type: ListingViewType.imageCard),
        const SizedBox(width: AppSpacing.small),
        buildButton(icon: Icons.view_list_rounded, type: ListingViewType.list),
      ],
    );
  }
}
