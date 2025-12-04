import 'package:event_app/features/directory/presentation/mentors_page.dart';
import 'package:event_app/features/directory/presentation/speakers_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/l10n/app_localizations.dart';

import '../../../core/theme/app_spacing.dart';

class DirectoryPage extends ConsumerWidget {
  const DirectoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SpeakersPage()),
          ),
          child: Text(AppLocalizations.of(context)!.speakersLabel),
        ),
        const SizedBox(height: AppSpacing.item),
        ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => MentorsPage()),
          ),
          child: Text(AppLocalizations.of(context)!.mentorsLabel),
        ),
      ],
    );
  }
}
