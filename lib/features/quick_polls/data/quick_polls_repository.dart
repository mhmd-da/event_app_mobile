import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/features/quick_polls/domain/quick_poll_models.dart';

class QuickPollsRepository extends BaseApiRepository<QuickPollModel>{
  QuickPollsRepository(super._apiClient) : super(fromJson: (json) => QuickPollModel.fromJson(json));

  Future<List<QuickPollModel>> getQuickPolls(int sessionId) async => fetchList(AppConfig.getQuickPolls(sessionId));

  Future<QuickPollResultsModel> vote(int sessionId, int pollId, int optionId) async => postDataGeneric<QuickPollResultsModel>(
    AppConfig.voteQuickPoll(sessionId, pollId),
    {
      'quickPollOptionId': optionId,
    },
    (data) => QuickPollResultsModel.fromJson(data));
    
}