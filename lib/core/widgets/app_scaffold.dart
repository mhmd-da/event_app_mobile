import 'package:event_app/features/notifications/presentation/notifications_page.dart';
import 'package:event_app/features/notifications/presentation/notifications_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/global_loading.dart';
import '../../features/settings/presentation/settings_page.dart';
import '../theme/app_colors.dart';

class AppScaffold extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(globalLoadingProvider) > 0;
    return Scaffold(
      appBar: title == null
          ? null
          : AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(gradient: AppColors.primaryGradient),
              ),
              title: Text(
                title!,
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(color: Colors.white),
              ),
              centerTitle: centerTitle,
              actions: [
                Builder(
                  builder: (_) {
                    final unreadAsync = ref.watch(unreadCountProvider);
                    final count = unreadAsync.maybeWhen(data: (c) => c, orElse: () => 0);
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.notifications_none_outlined,
                            color: Colors.white,
                          ),
                          tooltip: "Notifications",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const NotificationsPage(),
                              ),
                            );
                          },
                        ),
                        if (count > 0)
                          Positioned(
                            right: 6,
                            top: 6,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '$count',
                                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                  ),
                  tooltip: "Settings",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsPage()),
                    );
                  },
                ),
                // IconButton(
                //   icon: const Icon(
                //     Icons.event_available_outlined,
                //     color: Colors.white,
                //   ),
                //   tooltip: "Change Event",
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (_) => const EventsPage()),
                //     );
                //   },
                // ),
              ],
            ),

      body: SafeArea(
        // child: Padding(
        //   padding: const EdgeInsets.all(AppSpacing.page),
          child: Stack(
            children: [
              body,
              if (isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                    child: const Center(
                      child: SizedBox(
                        width: 64,
                        height: 64,
                        child: CircularProgressIndicator(strokeWidth: 4),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        // ),
      ),
      drawer: drawer,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
