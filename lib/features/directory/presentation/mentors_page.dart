import 'package:event_app/features/directory/presentation/details_page.dart';
import 'package:event_app/features/directory/presentation/directory_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/l10n/app_localizations.dart';

class MentorsPage extends ConsumerStatefulWidget {
  MentorsPage({super.key}); // no underscore prefix

  @override
  ConsumerState<MentorsPage> createState() => MentorsPageState();
}

class MentorsPageState extends ConsumerState<MentorsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mentorsAsync = ref.watch(mentorsListProvider);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.mentors)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // -------- SEARCH BAR TOP --------
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.searchHint,
                prefixIcon: const Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: mentorsAsync.when(
              data: (list) {
                // -------- APPLY LOCAL SEARCH FILTER --------
                final filtered = _searchText.trim().isEmpty
                    ? list
                    : list.where((person) {
                  final combined =
                  "${person.title} ${person.firstName} ${person.lastName} "
                      "${person.companyName ?? ''} "
                      "${person.position ?? ''}"
                      .toLowerCase();
                  return combined.contains(_searchText.toLowerCase());
                }).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Text(AppLocalizations.of(context)!.noMentorsFound),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async => ref.invalidate(mentorsListProvider),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final person = filtered[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: person.profileImageUrl != null
                              ? NetworkImage(person.profileImageUrl!)
                              : const Icon(Icons.person) as ImageProvider,
                        ),
                        title: Text("${person.title} ${person.firstName} ${person.lastName}"),
                        subtitle: Text("${person.companyName} — ${person.position}"),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PersonDetailsPage(person)),
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) =>
                  Center(child: Text('${AppLocalizations.of(context)!.errorLoadingMentors}: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
