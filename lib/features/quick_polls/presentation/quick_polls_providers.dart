import 'package:event_app/features/quick_polls/data/quick_polls_repository.dart';
import 'package:event_app/features/quick_polls/domain/quick_poll_models.dart';
import 'package:event_app/core/network/api_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quick_polls_providers.g.dart';



@Riverpod(keepAlive: true)
QuickPollsRepository quickPollsRepository(Ref ref) {
  return QuickPollsRepository(ref.watch(apiClientProvider));
}

@riverpod
Future<List<QuickPollModel>> quickPollsForSession(Ref ref, int sessionId) async {
  return ref.watch(quickPollsRepositoryProvider).getQuickPolls(sessionId);
}

class QuickPollState {
  final int currentIndex;
  final Map<int, int> selectedOptionByPollId; // pollId -> optionId
  final Map<int, QuickPollResultsModel> resultsByPollId; // pollId -> results

  const QuickPollState({
    this.currentIndex = 0,
    this.selectedOptionByPollId = const {},
    this.resultsByPollId = const {},
  });

  QuickPollState copyWith({
    int? currentIndex,
    Map<int, int>? selectedOptionByPollId,
    Map<int, QuickPollResultsModel>? resultsByPollId,
  }) {
    return QuickPollState(
      currentIndex: currentIndex ?? this.currentIndex,
      selectedOptionByPollId: selectedOptionByPollId ?? this.selectedOptionByPollId,
      resultsByPollId: resultsByPollId ?? this.resultsByPollId,
    );
  }
}

@Riverpod(keepAlive: true)
class QuickPollController extends _$QuickPollController {
  @override
  QuickPollState build(int sessionId) => const QuickPollState();

  QuickPollsRepository get _repo => ref.watch(quickPollsRepositoryProvider);

  void setIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }

  void selectOption(int pollId, int optionId) {
    final updated = Map<int, int>.from(state.selectedOptionByPollId);
    updated[pollId] = optionId;
    state = state.copyWith(selectedOptionByPollId: updated);
  }

  Future<void> submitVote(int pollId) async {
    final optionId = state.selectedOptionByPollId[pollId];
    if (optionId == null) return;
    final results = await _repo.vote(sessionId, pollId, optionId);
    final updated = Map<int, QuickPollResultsModel>.from(state.resultsByPollId);
    updated[pollId] = results;
    state = state.copyWith(resultsByPollId: updated);
  }
}
