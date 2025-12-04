import 'package:event_app/core/widgets/app_list_tile.dart';
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
          onTap: () {},
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
          onTap: () {},
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
