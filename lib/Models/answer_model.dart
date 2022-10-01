import 'package:flutter/material.dart';

///The [AnswerModel] holds parsed data of each Answer to a question
class AnswerModel {
  AnswerModel({
    @required this.questionId,
    @required this.answerId,
    @required this.answer
  });
  final questionId;
  final answerId;
  final answer;
  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
        questionId: json['question_id'],
        answerId: json['id'],
        answer: json['answer']
    );
  }
  static List<AnswerModel> parseList(List<dynamic> list) {
    return list.map((i) => AnswerModel.fromJson(i)).toList();
  }
}
