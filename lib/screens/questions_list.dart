import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:quiz_app/auth/login_screen.dart';
import 'package:quiz_app/widgets/question_card.dart';

import '../models/question.dart';
import '../utils/db_connect.dart';
import 'add_or_edit_question.dart';

class QuestionsList extends StatefulWidget {
  const QuestionsList({super.key});

  static const routeName = 'questionList';

  @override
  State<QuestionsList> createState() => _QuestionsListState();
}

class _QuestionsListState extends State<QuestionsList> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Questions List"),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          }, icon: const Icon(Icons.logout)),
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed(AddOrEditQuestionScreen.routeName);
          }, icon: const Icon(Icons.add))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: ()async {
          setState(() {
            questionList = getData();
          });
        },
        child: FutureBuilder(
          future: questionList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                var extracedData = snapshot.data as List<Question>;
                return ListView.builder(
                    itemCount: extracedData.length,
                    itemBuilder: ((context, index) => GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                              AddOrEditQuestionScreen.routeName,
                              arguments: extracedData[index]),
                          child: Dismissible(
                            key: Key(extracedData[index].id),
                            onDismissed: (_) {
                              db.deleteQuestion(extracedData[index].id);
                              extracedData.toList().removeAt(index);
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              child: const Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            child: QuestionCard(
                              question: extracedData[index],
                              index: index,
                            ),
                          ),
                        )));
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
