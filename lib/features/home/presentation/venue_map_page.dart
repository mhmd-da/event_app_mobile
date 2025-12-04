import 'package:event_app/core/widgets/app_list_tile.dart';
import 'package:event_app/features/faqs/presentation/faqs_page.dart';
import 'package:event_app/features/venue/presentation/venue_page.dart';
import 'package:flutter/material.dart';

class VenueInfoList extends StatelessWidget {
  const VenueInfoList({super.key}); // Added const constructor

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppListTile(
          leadingIcon: Icons.map,
          title: "Venue Map",
          subtitle: "View all halls and rooms",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const VenuePage()),
          ),
        ),
        const SizedBox(height: 8),
        AppListTile(
          leadingIcon: Icons.directions_bus,
          title: "Transportation",
          subtitle: "Shuttle routes & parking",
          onTap: () {},
        ),
        const SizedBox(height: 8),
        AppListTile(
          leadingIcon: Icons.help_center_outlined,
          title: "FAQs",
          subtitle: "Common questions",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => FaqsPage()),
          ),
        ),
        const SizedBox(height: 8),
        AppListTile(
          leadingIcon: Icons.contact_support_outlined,
          title: "Contact Us",
          subtitle: "Reach the organizers",
          onTap: () {},
        ),
      ],
    );
  }
}
