import 'package:event_app/core/base/base_model.dart';

class QuickPollOption extends BaseModel{
  final int id;
  final String text;
  final int? votes; // optional in listing; present in results

  QuickPollOption({required this.id, required this.text, this.votes});

  factory QuickPollOption.fromJson(Map<String, dynamic> json) {
    return QuickPollOption(
      id: json['id'] as int,
      text: json['text'] ?? json['label'] ?? '',
      votes: (json['voteCount'] ?? json['votes']) is int ? (json['voteCount'] ?? json['votes']) as int : null,
    );
  }
}

class QuickPollModel extends BaseModel {
  final int id;
  final String question;
  final List<QuickPollOption> options;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final bool userVoted;

  QuickPollModel({required this.id, required this.question, required this.options, this.startsAt, this.endsAt, this.userVoted = false});

  factory QuickPollModel.fromJson(Map<String, dynamic> json) {
    final rawOptions = (json['options'] as List?) ?? const [];
    return QuickPollModel(
      id: json['id'] as int,
      question: json['question'] ?? json['title'] ?? '',
      options: rawOptions.map((e) => QuickPollOption.fromJson(e as Map<String, dynamic>)).toList(),
      startsAt: json['startsAt'] != null ? DateTime.parse(json['startsAt']) : null,
      endsAt: json['endsAt'] != null ? DateTime.parse(json['endsAt']) : null,
      userVoted: (json['userVoted'] ?? false) as bool,
    );
  }
}

class QuickPollResultOption extends BaseModel {
  final int id;
  final String text;
  final int votes;

  QuickPollResultOption({required this.id, required this.text, required this.votes});

  factory QuickPollResultOption.fromJson(Map<String, dynamic> json) {
    return QuickPollResultOption(
      id: json['id'] as int,
      text: json['text'] ?? json['label'] ?? '',
      votes: (json['voteCount'] ?? json['votes'] ?? 0) as int,
    );
  }
}

class QuickPollResultsModel extends BaseModel {
  final int pollId;
  final List<QuickPollResultOption> options;
  final int totalVotes;

  QuickPollResultsModel({required this.pollId, required this.options, required this.totalVotes});

  factory QuickPollResultsModel.fromJson(Map<String, dynamic> json) {
    final rawOptions = (json['options'] as List?) ?? const [];
    final options = rawOptions.map((e) => QuickPollResultOption.fromJson(e as Map<String, dynamic>)).toList();
    final total = options.fold<int>(0, (sum, o) => sum + o.votes);
    return QuickPollResultsModel(
      pollId: (json['id'] ?? json['pollId']) as int,
      options: options,
      totalVotes: total,
    );
  }

  double percentageFor(int votes) {
    if (totalVotes <= 0) return 0.0;
    return votes / totalVotes;
  }
}
