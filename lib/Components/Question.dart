import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marry_me/Models/answer_model.dart';
import '/Components/Answer.dart';
import 'package:marry_me/Views/Splash.dart';

class Question extends StatefulWidget {
  Question({
    @required this.token,
    @required this.question,
    @required this.controller,
    @required this.index,
  });
  final controller, index, token, question;
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  bool visibility = false;
  // List<AnswerModel> Answers = [];
  // Future<int> callFunction() async{
  //   Answers = AnswerModel.parseList(widget.question.answers);
  //   print(widget.question.answers);
  //   // print(Answers.length);
  //   return 0;
  // }
  void initState() {
    super.initState();
    setState(() {
      if (visible == 1)
      {
        visibility=true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      widget.question.question,
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Color.fromRGBO(74, 74, 74, 1),
                      ),
                      maxLines: 5,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            // FutureBuilder(
            //     future: widget.question.answers,
            //     builder: (BuildContext context, AsyncSnapshot snapshot) {
            //       if (snapshot.data == null) {
            //         return Center(
            //             child: CircularProgressIndicator(
            //           valueColor: AlwaysStoppedAnimation<Color>(
            //               Color.fromRGBO(255, 98, 101, 1)),
            //         ));
            //       } else {
            //         return
            Container(
              child: Expanded(
                flex: 2,
                child: new ListView.builder(
                  itemCount: widget.question.answers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Answer(
                      ans: widget.question.answers[index],
                      index: widget.index,
                      controller: widget.controller,
                      token: widget.token,
                      question: widget.question,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: visibility,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Splash.routeName);
                          },
                          child: Text(
                            'تسجيل',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (states) => Color.fromRGBO(255, 98, 101, 1)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Color.fromRGBO(255, 98, 101, 1),
                                    width: 6.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
