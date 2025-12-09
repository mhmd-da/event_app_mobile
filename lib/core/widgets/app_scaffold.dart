import 'package:flutter/material.dart';
import '../../features/events/presentation/events_page.dart';
import '../theme/app_spacing.dart';
import '../theme/app_colors.dart';

class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final bool centerTitle;

  const AppScaffold({
    super.key,
    this.title,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.drawer,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title == null
          ? null
          : AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
        title: Text(
          title!,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
        ),
        centerTitle: centerTitle,
        actions: [
          IconButton(
            icon: const Icon(Icons.event_available_outlined, color: Colors.white),
            tooltip: "Change Event",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EventsPage(),
                ),
              );
            },
          )
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.page),
          child: body,
        ),
      ),
      drawer: drawer,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
