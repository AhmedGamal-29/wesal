import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marry_me/View_Model/question_view_model.dart';
import 'package:marry_me/Views/Splash.dart';
int visible = 0;

class Answer extends StatefulWidget {
  Answer({
    @required this.ans,
    @required this.token,
    @required this.question,
    @required this.index,
    @required this.controller,
  });
  final ans, token, question, index, controller;
  @override
  _AnswerState createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Color.fromRGBO(255, 98, 101, 1), width: 0.3),
        ),
        // shadowColor: Color.fromRGBO(255, 98, 101, 1),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                  splashColor: Color.fromRGBO(255, 98, 101, 1),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            widget.ans.answer,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromRGBO(74, 74, 74, 1),
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () async{
                    visible = await answerQuestion(widget.question, widget.ans, widget.token);
                    if (visible == 1)
                      {
                        Navigator.pushNamed(context, Splash.routeName);
                      }
                    widget.controller.animateToPage(widget.index + 1,
                        curve: Curves.ease,
                        duration: Duration(milliseconds: 500));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
