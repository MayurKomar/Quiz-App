import 'package:flutter/material.dart';

class PreviousScoreItem extends StatelessWidget {
  const PreviousScoreItem({super.key,required this.score,required this.date,required this.time});

  final String? score;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          Text(date),
          Text(time),
          Text(score!)
        ],),
      )
    );
  }
}