import 'package:flutter_riverpod/flutter_riverpod.dart';

/// This provider holds the current index of the main navigation bar.
///
/// Used to programmatically change the page from other parts of the app.
final mainNavigationIndexProvider = StateProvider<int>((ref) => 0);
