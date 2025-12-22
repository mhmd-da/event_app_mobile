import 'package:flutter/scheduler.dart';

/// Defers an action until after the current frame completes.
///
/// Use this to avoid modifying Riverpod providers during widget build
/// or other lifecycle methods. If called when the app is idle, the
/// action runs immediately.
void deferAfterBuild(void Function() action) {
  final phase = SchedulerBinding.instance.schedulerPhase;
  if (phase == SchedulerPhase.idle) {
    action();
    return;
  }
  SchedulerBinding.instance.addPostFrameCallback((_) => action());
}
