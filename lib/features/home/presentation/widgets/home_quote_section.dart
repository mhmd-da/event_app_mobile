import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HomeQuoteSection extends StatelessWidget {
  const HomeQuoteSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(color: Colors.black),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Image with black space above
          const SizedBox(height: 20),
          ClipRRect(
            child: Image.asset(
              'assets/images/leader_photo.png',
              width: double.infinity,
              height: 520,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 280,
                  color: Colors.black,
                  child: const Center(
                    child: Icon(Icons.person, size: 80, color: Colors.white24),
                  ),
                );
              },
            ),
          ),

          // Quote and text content
          Padding(
            padding: const EdgeInsets.all(AppSpacing.section),
            child: Column(
              children: [
                // Opening quotation mark
                const Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    '"',
                    style: TextStyle(
                      fontSize: 56,
                      color: Color(0xFF4A4A4A),
                      height: 0.8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Quote text
                Text(
                  l10n.homeQuoteText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    height: 1.8,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),

                // Closing quotation mark
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '"',
                    style: TextStyle(
                      fontSize: 56,
                      color: Color(0xFF4A4A4A),
                      height: 0.8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.section),

                // Leader title and name
                Text(
                  l10n.homeQuoteLeaderTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color.fromRGBO(255, 245, 157, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.homeQuoteLeaderName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color.fromRGBO(255, 245, 157, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.homeQuoteLeaderRole,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color.fromRGBO(255, 245, 157, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
