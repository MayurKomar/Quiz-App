import '../Constants/constants.dart';
import 'package:flutter/material.dart';

class ResultDialog extends StatelessWidget {
  const ResultDialog(
      {super.key,
      required this.score,
      required this.questionLength,
      required this.onTap});

  final int score;
  final int questionLength;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Score",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 50,
              backgroundColor: score == questionLength / 2
                  ? Colors.yellow
                  : score < questionLength / 2
                      ? Constants.wrongAnswerColor
                      : Constants.correctAnswerColor,
              child: Text(
                '$score/$questionLength',
                style: const TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              score == questionLength / 2
                  ? 'Almost There'
                  : score < questionLength / 2
                      ? 'Try Again'
                      : 'Great',
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              onPressed: onTap,
              child: const Text(
                "Start Over",
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text(
                "Home",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
