class QuizQuestion {
  final String questionText;
  //Danh sách các câu trả lời cho user chọn
  final List<String> answers;

  const QuizQuestion(this.questionText, this.answers);

  List<String> getShuffleAnswer() {
    List<String> copy = [...answers];
    copy.shuffle();

    return copy;
  }
}
