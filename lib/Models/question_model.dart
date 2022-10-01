import 'package:flutter/material.dart';
import 'answer_model.dart';

///The [QuestionModel] holds parsed data of each Question
class QuestionModel {
  QuestionModel({
    @required this.questionId,
    @required this.question,
    @required this.gender,
    @required this.answers,
  });
  final questionId;
  final question;
  final gender;
  final answers;
  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      questionId: json['question']['id'],
      question: json['question']['question'],
      gender: json['question']['gender'],
      answers: AnswerModel.parseList(json['answers']),
    );
  }
  static List<QuestionModel> parseList(List<dynamic> list) {
    return list.map((i) => QuestionModel.fromJson(i)).toList();
  }
}
