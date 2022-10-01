class QuestionUser{
  var question_id;
  var question;
  var answer;
  var hidden;
  QuestionUser({
    required this.question_id,
    required this.question,
    required this.answer,
    required this.hidden,
});
/*
  QuestionUser.fromJson(Map<String,dynamic> json):this(
    question_id: json['id'],
    question: json['question'],//json['question'],
    answer: json['answer'],//json['answer'],
    hidden:json['hidden'],
  );
*/

}

