import 'package:event_app/core/widgets/app_list_tile.dart';
import 'package:event_app/features/contact/presentation/contact_form_page.dart';
import 'package:event_app/features/faqs/presentation/faqs_page.dart';
import 'package:event_app/features/venue/presentation/venue_page.dart';
import 'package:flutter/material.dart';
import 'package:event_app/l10n/app_localizations.dart';

class VenueInfoList extends StatelessWidget {
  const VenueInfoList({super.key}); // Added const constructor

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        AppListTile(
          leadingIcon: Icons.map,
          title: l10n.venueMap,
          subtitle: l10n.venueMapSubtitle,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const VenuePage()),
          ),
        ),
        const SizedBox(height: 8),
        // AppListTile(
        //   leadingIcon: Icons.directions_bus,
        //   title: "Transportation",
        //   subtitle: "Shuttle routes & parking",
        //   onTap: () {},
        // ),
        // const SizedBox(height: 8),
        AppListTile(
          leadingIcon: Icons.help_center_outlined,
          title: l10n.faqs,
          subtitle: l10n.faqsSubtitle,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => FaqsPage()),
          ),
        ),
        const SizedBox(height: 8),
        AppListTile(
          leadingIcon: Icons.contact_support_outlined,
          title: l10n.contactUs,
          subtitle: l10n.contactUsSubtitle,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ContactFormPage()),
          ),
        ),
      ],
    );
  }
}
