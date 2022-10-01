import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:marry_me/Components/CustomDrawer.dart';
import 'package:marry_me/Components/LastMessageCard.dart';
import 'package:marry_me/Components/SendMessageButtonComponent.dart';
import 'package:marry_me/Components/SendMessageItem.dart';
import 'package:marry_me/Components/ReceivedMessageItem.dart';
import 'package:marry_me/View_Model/UserViewModel.dart';
import 'package:marry_me/Views/Home.dart';
import 'package:marry_me/Views/Splash.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Components/Question.dart';
import '../Components/AppBar.dart';
import '../Globals.dart';
import '../Models/question_model.dart';
import '../Models/User.dart';
import '../View_Model/question_view_model.dart';


String token = KUserToken;
class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);
  static const routeName = 'Quiz';

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<QuestionModel> questions = [];
  Future<int> callFunction() async {
    questions = await getQuestions(token);
    return 0;
  }

  final PageController _controller = new PageController();
  bool visible = false;
  @override
  void initState() {
    super.initState();
    // callFunction();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          toolbarHeight: 75.0,
          titleSpacing: 0,
          title: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.03,
              left: MediaQuery.of(context).size.width * 0.04,
            ),
            child: Text(
              "معلومات المستخدم",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(255, 98, 101, 1),
                // color: Colors.white,
              ),
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Image(
              image: AssetImage('assets/images/marryme.png'),
              // width: 200.0,
              // height: 200.0,
            ),
          ),
          actions: [
            TextButton(
                child: Text(
                  "خروج",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(255, 98, 101, 1),
                    // color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Splash.routeName);
                }),
          ],
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: callFunction(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(255, 98, 101, 1)),
                ));
              } else {
                return Stack(
                  children: [
                    PageView.builder(
                      controller: _controller,
                      itemBuilder: (context, index) {
                        // index gives you current page position.
                        if (index == questions.length)
                        {
                          visible = true;
                        }
                        return Question(
                          controller: _controller,
                          index: index,
                          token: token,
                          question: questions[index],
                          // question: "ما هى وظيفتك؟",
                        );
                      },
                      itemCount: questions.length, // Can be null
                      // itemCount: 3, // Can be null
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.82,
                      left: MediaQuery.of(context).size.width * 0.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: SmoothPageIndicator(
                              controller: _controller, // PageController
                              count: questions.length,
                              effect: ScrollingDotsEffect(
                                  radius: 4,
                                  dotHeight: 8,
                                  dotWidth: 8,
                                  dotColor: Color.fromRGBO(74, 74, 74, 1),
                                  activeDotColor:
                                      Color.fromRGBO(255, 98, 101, 1)),
                              onDotClicked: (index) =>
                                  _controller.animateToPage(index,
                                      curve: Curves.ease,
                                      duration: Duration(milliseconds: 400)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }
}
