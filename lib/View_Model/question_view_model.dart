import 'dart:convert';
// import 'dart:html';
// import 'package:flickr/Constants/constants.dart';
import 'package:http/http.dart' as http;
// import 'dart:io';
import 'package:dio/dio.dart';
import 'package:marry_me/Models/answer_model.dart';
import '../Models/question_model.dart';

String baseUrl = "http://10.0.2.2:8000";

getQuestions(String token) async {
  var req = await http.get(
      (Uri.parse(baseUrl + "/api/get-all-questions-with-gender")),
      headers: {"authorization": "Bearer " + token});
  List<QuestionModel> questions = [];
  if (req.statusCode == 200) {
    print(req.body);
    String data = req.body;
    List<dynamic> info = jsonDecode(data)[0];
    questions = QuestionModel.parseList(info);
    return questions;
  } else {
    print(req.body);
    return questions;
  }
}

answerQuestion(QuestionModel question, AnswerModel answer, String token) async {
  var req2 = await Dio().post((baseUrl + '/api/save-answer'),
      options: Options(
          headers: {"authorization": "Bearer " + token},
          responseType: ResponseType.json),
      data: jsonEncode({
        "question_id": question.questionId,
        "answer": answer.answer,
      }));
  // print(req2.data["message"]);
  print(req2.data);
  return req2.data["Answered"];
}