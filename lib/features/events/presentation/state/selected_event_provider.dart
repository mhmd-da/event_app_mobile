import 'package:event_app/features/events/domain/event_details_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_event_provider.g.dart';

@Riverpod(keepAlive: true)
class SelectedEvent extends _$SelectedEvent {
	@override
	EventDetailsModel? build() => null;
	void set(EventDetailsModel? value) => state = value;
}
