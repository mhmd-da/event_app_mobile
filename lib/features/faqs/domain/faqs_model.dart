class Faq {
  final String question;
  final String answer;
  final String? category;
  final int? sortOrder;

  Faq({required this.question, required this.answer, this.category, this.sortOrder});

  factory Faq.fromJson(Map<String, dynamic> json) {
    return Faq(
      question: json['question'],
      answer: json['answer'],
      category: json['category'],
      sortOrder: json['sortOrder'] as int?,
    );
  }
}