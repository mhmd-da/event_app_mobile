import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomSearchBar extends ConsumerStatefulWidget {
  final EdgeInsetsGeometry padding;
    final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? hintText;


  const CustomSearchBar({super.key, 
  this.padding = const EdgeInsets.all(12),
  this.onChanged,
  this.controller,
  this.hintText,
});

  @override
  ConsumerState<CustomSearchBar> createState() => CustomSearchBarState();
}

class CustomSearchBarState extends ConsumerState<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: TextField(
        controller: widget.controller ?? _searchController,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hintText ?? AppLocalizations.of(context)!.searchHint,
          prefixIcon: const Icon(Icons.search),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
