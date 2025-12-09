import 'package:flutter/material.dart';

class AppDecorations {

    static BoxDecoration agendaSessionCard(BuildContext ctx, {Color? bgColor}) => BoxDecoration(
    borderRadius: BorderRadius.circular(14),
    border: Border(left: BorderSide(color: bgColor ?? Theme.of(ctx).primaryColor, width: 5)),
    //color: bgColor ?? Theme.of(ctx).cardColor.withOpacity(0.06),
    boxShadow: [
      BoxShadow(
        blurRadius: 6,
        spreadRadius: 1,
        offset: const Offset(0, 2),
        color: bgColor ?? Theme.of(ctx).primaryColor.withOpacity(0.01),
      )
    ],
  );

  static BoxDecoration cardContainer(BuildContext ctx) => BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    color: Theme.of(ctx).cardTheme.color!,
    boxShadow: [
      BoxShadow(
        blurRadius: 8,
        spreadRadius: 1,
        offset: const Offset(0, 3),
        color: Theme.of(ctx).cardTheme.color!.withOpacity(0.08),
      )
    ],
  );

  static BoxDecoration listTileContainer(BuildContext ctx) => BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: Theme.of(ctx).colorScheme.surface,
    boxShadow: [
      BoxShadow(
        blurRadius: 5,
        spreadRadius: 1,
        offset: const Offset(0, 2),
        color: Theme.of(ctx).shadowColor.withOpacity(0.05),
      )
    ],
  );

  static ButtonStyle primaryButton(BuildContext ctx) =>
      ElevatedButton.styleFrom(
        backgroundColor: Theme.of(ctx).colorScheme.primary,
        foregroundColor: Theme.of(ctx).colorScheme.onPrimary,
        padding:
        const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      );

  static BoxDecoration chipContainer(BuildContext ctx) => BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Theme.of(ctx).chipTheme.backgroundColor,
    boxShadow: [
      BoxShadow(
        blurRadius: 3,
        spreadRadius: 1,
        offset: const Offset(0, 1),
        color: Theme.of(ctx).shadowColor.withOpacity(0.04),
      )
    ],
  );

  static BoxDecoration logoCardContainer(BuildContext ctx) =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Theme.of(ctx).cardColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 2),
            color: Theme.of(ctx).shadowColor.withOpacity(0.06),
          )
        ],
      );

  static BoxDecoration tabButton(BuildContext ctx, {Color? bgColor}) => BoxDecoration(
    borderRadius: BorderRadius.circular(14),
    color: bgColor ?? Theme.of(ctx).cardColor.withOpacity(0.06),
    boxShadow: [
      BoxShadow(
        blurRadius: 6,
        spreadRadius: 1,
        offset: const Offset(0, 2),
        color: Theme.of(ctx).shadowColor.withOpacity(0.04),
      )
    ],
  );
}
