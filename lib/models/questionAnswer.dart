import 'dart:convert';

List<QuestionAnswer> questionAnswerFromJson(data) => List<QuestionAnswer>.from(json.decode(data)["questionAnswer"].map((value) => QuestionAnswer.fromJson(value)));

class QuestionAnswer{

  int? id;
  String? question;
  String? questionAr;
  String? answer;
  String? answerAr;

  QuestionAnswer({
    this.id, this.question, this.questionAr, this.answer, this.answerAr
  });

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) => QuestionAnswer(
    id: json["id"],
    question: json["question"],
    questionAr: json["question_ar"],
    answer: json["answer"],
    answerAr: json["answer_ar"],
  );
}