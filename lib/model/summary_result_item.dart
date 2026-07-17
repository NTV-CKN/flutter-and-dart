class SummaryResultItem {
  int indexItem;
  String questionText;
  String answer;
  String userAnswered;

  SummaryResultItem({
    required this.indexItem,
    required this.questionText,
    required this.answer,
    required this.userAnswered,
  });

  bool checkCorrectAnswer() => userAnswered == answer;
}
