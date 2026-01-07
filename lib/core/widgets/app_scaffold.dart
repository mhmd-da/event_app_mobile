import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/global_loading.dart';
import '../../features/settings/presentation/settings_page.dart';
import '../theme/app_colors.dart';
import 'app_buttons.dart';
import '../../core/network/network_status_provider.dart';

// File-level navigation guards to prevent multiple pushes
bool _settingsNavGuard = false;

class AppScaffold extends ConsumerStatefulWidget {
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
  ConsumerState<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends ConsumerState<AppScaffold> {
  bool _showOnlineBanner = false;
  NetworkStatus? _lastNetworkStatus;
  double _scrollOffset = 0.0;
  static const double maxAppBarHeight = 100;

  void _onScroll(double offset) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _scrollOffset = offset.clamp(
            0,
            33.33,
          ); // 100 - 80 = 20, 20/0.6 = ~33.33
        });
      }
    });
  }

  double get _appBarHeight =>
      maxAppBarHeight - (_scrollOffset * 0.6); // 0..33.33*0.6=20
  double get _appBarOpacity => 1.0 - (_scrollOffset / 40 * 0.25);
  double get _titleHorizontalPadding => 40 - (_scrollOffset.clamp(0, 40) * 0.5);

  // Navigation guards to prevent multiple pushes (file-level, persist across rebuilds)

  @override
  Widget build(BuildContext context) {
    final ref = this.ref;
    final networkStatus =
        ref.watch(networkStatusProvider).asData?.value ?? NetworkStatus.online;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Only show green banner for 2 seconds if we just reconnected
      if (_lastNetworkStatus == NetworkStatus.offline &&
          networkStatus == NetworkStatus.online) {
        setState(() => _showOnlineBanner = true);
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) setState(() => _showOnlineBanner = false);
        });
      }
      _lastNetworkStatus = networkStatus;
    });
    final isLoading = ref.watch(globalLoadingProvider) > 0;
    return Scaffold(
      appBar: widget.title == null
          ? null
          : PreferredSize(
              preferredSize: Size.fromHeight(_appBarHeight),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: _appBarHeight,
                  child: Stack(
                    children: [
                      // Blur background (Glassmorphism)
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                          ),
                        ),
                      ),
                      // Drop shadow below app bar
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: -8,
                        child: Container(
                          height: 16,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: _appBarOpacity,
                        child: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          iconTheme: const IconThemeData(color: Colors.white),
                          actionsIconTheme: const IconThemeData(
                            color: Colors.white,
                          ),
                          title: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(
                              horizontal: _titleHorizontalPadding,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.surface.withOpacity(0.85),
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              widget.title!,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          centerTitle: widget.centerTitle,
                          actions: [
                            AppIconButton(
                              icon: Icon(
                                Icons.settings_outlined,
                                color: Colors.white,
                              ),
                              tooltip: 'Settings',
                              onPressed: () {
                                if (_settingsNavGuard) return;
                                _settingsNavGuard = true;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const SettingsPage(),
                                  ),
                                ).then((_) {
                                  _settingsNavGuard = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.axis == Axis.vertical) {
              _onScroll(notification.metrics.pixels);
            }
            return false;
          },
          child: Stack(
            children: [
              widget.body,
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
              // Global network status banner
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AnimatedSlide(
                  offset:
                      (networkStatus == NetworkStatus.offline ||
                          _showOnlineBanner)
                      ? Offset.zero
                      : const Offset(0, -1),
                  duration: const Duration(milliseconds: 300),
                  child: _showOnlineBanner
                      ? Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          color: Colors.green,
                          child: const Center(
                            child: Text(
                              'Connected',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : (networkStatus == NetworkStatus.offline
                            ? Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                color: Colors.red,
                                child: const Center(
                                  child: Text(
                                    'You are offline',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink()),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: widget.drawer,
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
