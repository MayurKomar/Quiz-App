import 'dart:convert';

import '../Constants/constants.dart';
import '../models/question.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

class DbConnect {
  final url = Uri.parse(
      "https://assignment-quiz-default-rtdb.firebaseio.com/questions.json");
  List<Question> questions = [];

  Future<void> addQuestion(Question question) async {
    // http.post(url,
    //     body: json
    //         .encode({'question': question.title, 'options': question.options}));
    FirebaseDatabase.instance.ref().child('questions').child(question.id).set({
      Constants.question: question.title,
      Constants.options : question.options,
    });
  }

  Future<List<Question>> fetchQuestions() async {
    questions.clear();
    await http.get(url).then((response) {
      if (response.statusCode == 200) {
        var data = json.decode(response.body) as Map<String, dynamic>;
        data.forEach((key, value) {
          var newQuestion = Question(
              id: key,
              options: Map.castFrom(value['options']),
              title: value['question']);
          questions.add(newQuestion);
        });
      }
    });
    return questions;
  }

  void updateQuestion(Question question) {
    FirebaseDatabase.instance.ref().child("questions").child(question.id).update({
      Constants.question: question.title,
      Constants.options : question.options,
    });
  }

  void deleteQuestion(String questionId){
    FirebaseDatabase.instance.ref().child("questions").child(questionId).remove();
  }
}
