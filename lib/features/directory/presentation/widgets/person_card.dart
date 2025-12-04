import 'package:flutter/material.dart';

import '../../domain/person_model.dart';
import '../person_profile_page.dart';

class PersonCard extends StatelessWidget {
  final PersonModel person;

  const PersonCard({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundImage: person.profileImageUrl != null
              ? NetworkImage(person.profileImageUrl!)
              : const AssetImage('assets/images/avatar_placeholder.png')
          as ImageProvider,
        ),
        title: Text(
          person.firstName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          person.position ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PersonProfilePage(person: person),
            ),
          );
        },
      ),
    );
  }
}
