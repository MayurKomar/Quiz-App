import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/utils/db_connect.dart';

// ignore: must_be_immutable
class QuestionCard extends StatelessWidget {
  QuestionCard({super.key, required this.question, required this.index});

  final Question question;
  int index;
  var db = DbConnect();

  TextStyle optionsStyle = const TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            Text(
              question.title,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'A. ${question.options.keys.toList()[0]}',
                  style: optionsStyle,
                ),
                const Spacer(),
                Text(
                  'B. ${question.options.keys.toList()[1]}',
                  style: optionsStyle,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'C. ${question.options.keys.toList()[2]}',
                  style: optionsStyle,
                ),
                const Spacer(),
                Text(
                  'D. ${question.options.keys.toList()[3]}',
                  style: optionsStyle,
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
