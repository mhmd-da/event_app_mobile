import 'package:event_app/features/events/presentation/state/selected_event_provider.dart';
import 'package:event_app/features/my_schedule/presentation/my_schedule_page.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/widgets/app_scaffold.dart';
import '../features/home/presentation/home_page.dart';
import '../features/agenda/presentation/agenda_page.dart';
import '../features/profile/presentation/profile_page.dart';
import 'main_navigation_providers.dart';
import 'side_navigation_drawer.dart';
import 'package:event_app/core/widgets/notifier.dart';

class MainNavigationPage extends ConsumerStatefulWidget {
  const MainNavigationPage({super.key});

  @override
  ConsumerState<MainNavigationPage> createState() =>
      _MainNavigationPageState();
}

class _MainNavigationPageState extends ConsumerState<MainNavigationPage> {
  DateTime? _lastBackTime;
  
  Widget _pageForIndex(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const AgendaPage();
      case 2:
        return const MySchedulePage();
      case 3:
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final event = ref.watch(selectedEventProvider);
    final currentIndex = ref.watch(mainNavigationIndexProvider);

    // No PageView, so no listener needed for controller.

    if (event == null) {
      return Center(child: Text(AppLocalizations.of(context)!.noEventSelected));
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        // If not on home, go to home instead of exiting
        if (currentIndex != 0) {
          ref.read(mainNavigationIndexProvider.notifier).set(0);
          return;
        }
        // Double back to exit on home
        final now = DateTime.now();
        if (_lastBackTime == null || now.difference(_lastBackTime!) > const Duration(seconds: 2)) {
          _lastBackTime = now;
          if (mounted) {
            AppNotifier.bottomMessage(context, AppLocalizations.of(context)!.pressBackAgainToExit);
          }
          return;
        }
        SystemNavigator.pop();
      },
      child: AppScaffold(
        title: _titleForIndex(currentIndex),
        drawer: const SideNavigationDrawer(),
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => ref.read(mainNavigationIndexProvider.notifier).set(index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_rounded),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.event_rounded),
            label: AppLocalizations.of(context)!.agenda,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.schedule_rounded),
            label: AppLocalizations.of(context)!.mySchedule,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_rounded),
            label: AppLocalizations.of(context)!.profile,
          ),
        ],
        ),
        body: _pageForIndex(currentIndex),
      ),
    );
  }

  String _titleForIndex(int index) {
    switch (index) {
      case 0:
        return AppLocalizations.of(context)!.home;
      case 1:
        return AppLocalizations.of(context)!.agenda;
      case 2:
        return AppLocalizations.of(context)!.mySchedule;
      case 3:
        return AppLocalizations.of(context)!.profile;
      default:
        return "";
    }
  }
}
