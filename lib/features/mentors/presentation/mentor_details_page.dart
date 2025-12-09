import 'package:event_app/features/mentors/domain/mentor_model.dart';
import 'package:flutter/material.dart';
import 'package:event_app/l10n/app_localizations.dart';

class MentorDetailsPage extends StatelessWidget {
  final MentorModel person;
  const MentorDetailsPage(this.person, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.mentors)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(person.profileImageUrl ?? ""),
              ),
            ),
            Center(
              child: Text("${person.title} ${person.firstName} ${person.lastName}",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Text("${person.companyName} - ${person.position}", textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),

            const Divider(),

            Text(person.bio?? "", style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
