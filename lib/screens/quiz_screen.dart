import '../Constants/constants.dart';
import '../models/question.dart';
import '../utils/db_connect.dart';
import '../widgets/next_button.dart';
import '../widgets/optin_card.dart';
import '../widgets/question_widget.dart';
import '../widgets/result_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  static const routeName = "quizscreen";

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  var db = DbConnect();
  late Future<List<Question>> questionList;

  Future<List<Question>> getData() async {
    return db.fetchQuestions();
  }

  @override
  void initState() {
    questionList = getData();
    super.initState();
  }

  int index = 0;
  bool isPressed = false;
  int score = 0;
  bool isAlreadySelected = false;

  final _firestore = FirebaseFirestore.instance.collection(Constants.user);
  final _auth = FirebaseAuth.instance;

  void startOverQuiz() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  void nextQuestion(int questionLength) async {
    var snapshot = _firestore.doc(_auth.currentUser?.uid);
    String topScoreString = await snapshot.get().then((value) => value['topScore']);
    int topScore = int.parse(topScoreString);
    if (index >= questionLength - 1) {
      if (topScore < score) {
        _firestore
            .doc(_auth.currentUser?.uid)
            .update({Constants.topScore: score.toString()});
      }
      _firestore
          .doc(_auth.currentUser?.uid)
          .collection(Constants.prevScores)
          .doc(DateTime.now().toString())
          .set({
        Constants.date: DateFormat("dd-MM-yyyy").format(DateTime.now()),
        Constants.time: DateFormat.Hm().format(DateTime.now()),
        Constants.score: score.toString()
      });
      if(isAlreadySelected){
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: ((context) => ResultDialog(
              onTap: startOverQuiz,
              score: score,
              questionLength: questionLength,
            )));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
          Text(" Please select an option to move forward to next question"),
          behavior: SnackBarBehavior.floating,
        ));
      }
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text(" Please select an option to move forward to next question"),
          behavior: SnackBarBehavior.floating,
        ));
      }
    }
  }

  void optionTapped(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        setState(() {
          score++;
        });
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: questionList,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data as List<Question>;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Quiz"),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Score: $score',
                      style: const TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
              body: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(children: [
                    QuestionWidget(
                        question: extractedData[index].title,
                        indexAction: index,
                        totalQuestion: extractedData.length),
                    const Divider(
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    for (int i = 0;
                        i < extractedData[index].options.length;
                        i++)
                      GestureDetector(
                        onTap: () {
                          optionTapped(
                              extractedData[index].options.values.toList()[i]);
                        },
                        child: OptionCard(
                          option: extractedData[index].options.keys.toList()[i],
                          color: isPressed
                              ? extractedData[index]
                                          .options
                                          .values
                                          .toList()[i] ==
                                      true
                                  ? Constants.correctAnswerColor
                                  : Constants.wrongAnswerColor
                              : Colors.white.withOpacity(0.1),
                        ),
                      )
                  ]),
                ),
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: NextButton(
                  nextQuestion: () {
                    nextQuestion(extractedData.length);
                  },
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const Center(
          child: Text('No data'),
        );
      }),
    );
  }
}
