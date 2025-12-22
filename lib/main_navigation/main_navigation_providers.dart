import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_navigation_providers.g.dart';

/// This provider holds the current index of the main navigation bar.
/// Used to programmatically change the page from other parts of the app.
@riverpod
class MainNavigationIndex extends _$MainNavigationIndex {
	@override
	int build() => 0;
	void set(int index) => state = index;
}
