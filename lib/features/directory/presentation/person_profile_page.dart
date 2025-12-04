import 'package:event_app/features/directory/domain/person_model.dart';
import 'package:flutter/material.dart';
import 'package:event_app/l10n/app_localizations.dart';

import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_section_title.dart';

class PersonProfilePage extends StatelessWidget {
  final PersonModel person;

  const PersonProfilePage({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: person.title,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // AVATAR
            CircleAvatar(
              radius: 48,
              backgroundImage: person.profileImageUrl != null
                  ? NetworkImage(person.profileImageUrl!)
                  : const AssetImage('assets/images/avatar_placeholder.png')
              as ImageProvider,
            ),

            const SizedBox(height: 12),
            Text(
              person.firstName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (person.position != null && person.position!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                person.position!,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],

            const SizedBox(height: 16),

            // SOCIAL LINKS (optional)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (person.linkedinUrl != null &&
                    person.linkedinUrl!.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.linked_camera_outlined),
                    onPressed: () {
                      // TODO: open LinkedIn URL with url_launcher
                    },
                  ),
                if (person.twitterUrl != null &&
                    person.twitterUrl!.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.alternate_email),
                    onPressed: () {
                      // TODO: open Twitter URL with url_launcher
                    },
                  ),
              ],
            ),

            const SizedBox(height: 24),

            // BIO
            if (person.bio != null && person.bio!.isNotEmpty) ...[
              AppSectionTitle(title: AppLocalizations.of(context)!.about),
              const SizedBox(height: 8),
              Text(
                person.bio!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
            ],

            // SESSIONS
            AppSectionTitle(title: AppLocalizations.of(context)!.sessions),
            const SizedBox(height: 8),
            if (person.sessions.isEmpty)
              Text(AppLocalizations.of(context)!.noSessionsLinkedYet)
            else
              Column(
                children: person.sessions
                    .map(
                      (s) => ListTile(
                    leading: const Icon(Icons.event),
                    title: Text(s),
                  ),
                )
                    .toList(),
              ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
